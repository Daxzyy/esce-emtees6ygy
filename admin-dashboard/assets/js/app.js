(function () {
"use strict";

/* ===================== Config ===================== */
const ROOT = "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app";
const BASE = ROOT + "/devices";
const BANS = ROOT + "/banned";
const PASSWORD = "banned";
const AUTH_HEADER = "Basic YWRtaW46YWRtaW4=";

const AUTH_KEY = "ujian_admin_auth";
const THEME_KEY = "ujian_admin_theme";
const ONLINE_MS = 10000;   // now - lastSeen <= 10 detik => Online
const REFRESH_MS = 4000;   // ambil data baru tiap 4 detik
const TZ = "Asia/Jakarta";

/* ===================== Helpers ===================== */
function qs(sel, root) { return (root || document).querySelector(sel); }

function h(v) {
  if (v === undefined || v === null) return "";
  return String(v).replace(/[&<>"']/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
}

function dash(v) {
  const s = v === undefined || v === null ? "" : String(v).trim();
  return s === "" ? "-" : h(s);
}

function valid(v) {
  return v !== undefined && v !== null && String(v).trim() !== "" && String(v).trim() !== "Tidak diketahui";
}

const store = {
  get(k) { try { return localStorage.getItem(k); } catch (e) { return null; } },
  set(k, v) { try { localStorage.setItem(k, v); } catch (e) { /* abaikan */ } },
  del(k) { try { localStorage.removeItem(k); } catch (e) { /* abaikan */ } }
};

// Hash ringan (bukan keamanan sungguhan, dashboard ini client-side). Gunanya supaya
// login tersimpan otomatis tidak valid lagi kalau PASSWORD diganti.
function hashPw(s) {
  const str = "ujian:" + s;
  let x = 5381;
  for (let i = 0; i < str.length; i++) x = ((x << 5) + x + str.charCodeAt(i)) | 0;
  return "v1-" + (x >>> 0).toString(36);
}
function isAuthed() { return store.get(AUTH_KEY) === hashPw(PASSWORD); }

/* ===================== Waktu ===================== */
let serverOffset = 0; // server - klien (ms), dari header Date Firebase kalau terbaca
function nowMs() { return Date.now() + serverOffset; }

const MONTHS = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"];
const dtf = new Intl.DateTimeFormat("en-GB", {
  timeZone: TZ, year: "numeric", month: "numeric", day: "numeric",
  hour: "numeric", minute: "numeric", hourCycle: "h23"
});
function zparts(ms) {
  const o = {};
  for (const p of dtf.formatToParts(new Date(ms))) if (p.type !== "literal") o[p.type] = parseInt(p.value, 10);
  return o;
}
function dayNum(p) { return Math.floor(Date.UTC(p.year, p.month - 1, p.day) / 86400000); }
function pad(n) { return n < 10 ? "0" + n : String(n); }

// "Hari ini 14.32" / "Kemarin 09.10" / "22 Nov 2026, 14.32"
function fmtDate(ts, now) {
  const n = Number(ts);
  if (!n || isNaN(n)) return "-";
  const p = zparts(n);
  const diff = dayNum(zparts(now)) - dayNum(p);
  const t = pad(p.hour) + "." + pad(p.minute);
  if (diff <= 0) return "Hari ini " + t;
  if (diff === 1) return "Kemarin " + t;
  return p.day + " " + MONTHS[p.month - 1] + " " + p.year + ", " + t;
}

function fmtClock(ms) {
  const d = new Date(ms);
  const parts = new Intl.DateTimeFormat("en-GB", { timeZone: TZ, hour: "2-digit", minute: "2-digit", second: "2-digit", hourCycle: "h23" }).formatToParts(d);
  const o = {};
  parts.forEach(p => { o[p.type] = p.value; });
  return o.hour + "." + o.minute + "." + o.second;
}

/* ===================== Format device ===================== */
function deviceName(r) {
  const model = valid(r.model) ? String(r.model).trim() : "";
  let maker = valid(r.manufacturer) ? String(r.manufacturer).trim() : "";
  if (maker) maker = maker.charAt(0).toUpperCase() + maker.slice(1);
  let name = model;
  if (maker && !model.toLowerCase().startsWith(maker.toLowerCase())) name = (maker + " " + model).trim();
  return name || "Device tanpa nama";
}

function chipsetName(r) {
  if (valid(r.chipset)) return String(r.chipset).trim();
  if (valid(r.socModel)) return String(r.socModel).trim();
  if (valid(r.hardware)) return String(r.hardware).trim();
  return "-";
}

function fmtRam(mb) {
  const n = Number(mb);
  if (!n || n <= 0) return "-";
  if (n < 1024) return Math.round(n) + " MB";
  return (Math.round(n / 1024 * 10) / 10).toString().replace(".", ",") + " GB";
}

function fmtStorage(gb) {
  const n = Number(gb);
  if (!n || n <= 0) return "-";
  if (n >= 1024) return (Math.round(n / 1024 * 10) / 10).toString().replace(".", ",") + " TB";
  return n + " GB";
}

function androidText(r) {
  const v = valid(r.androidVersion) ? String(r.androidVersion).trim() : "";
  const sdkRaw = r.sdkInt !== undefined && r.sdkInt !== null && r.sdkInt !== "" ? r.sdkInt : r.sdk;
  const sdk = valid(sdkRaw) ? String(sdkRaw).trim() : "";
  if (!v && !sdk) return "-";
  const a = v ? (/^android/i.test(v) ? v : "Android " + v) : "";
  if (a && sdk) return a + " (SDK " + sdk + ")";
  return a || "SDK " + sdk;
}

function isBanned(v) {
  if (v === true) return true;
  return !!v && typeof v === "object" && v.banned === true;
}

/* ===================== State ===================== */
let devices = [];          // data mentah dari Firebase (+ code, banned)
let filter = "all";        // all | online | offline | banned
let query = "";
let session = 0;           // naik tiap login/logout, supaya fetch lama diabaikan
let inflight = false;
let loaded = false;
let loadError = "";
let pollTimer = null;
let tickTimer = null;
const cards = new Map();   // code -> { el, html, cls }

/* ===================== Network ===================== */
async function jf(u, opts) {
  const o = opts || {};
  const r = await fetch(u, { ...o, headers: { "Authorization": AUTH_HEADER, ...(o.headers || {}) } });
  try {
    const d = Date.parse(r.headers.get("date") || "");
    if (!isNaN(d)) serverOffset = d - Date.now();
  } catch (e) { /* header tidak terbaca (CORS), pakai jam browser */ }
  if (!r.ok) throw new Error("HTTP " + r.status);
  return r.json();
}

async function refresh() {
  if (inflight || document.hidden || !qs("#list")) return;
  const my = session;
  inflight = true;
  try {
    const [devs, bans] = await Promise.all([jf(BASE + ".json"), jf(BANS + ".json")]);
    if (my !== session) return;
    const banMap = bans && typeof bans === "object" ? bans : {};
    devices = Object.entries(devs || {}).map(([code, v]) =>
      Object.assign({}, v && typeof v === "object" ? v : {}, { code, banned: isBanned(banMap[code]) })
    );
    loaded = true;
    loadError = "";
    setConn(true);
    render();
  } catch (e) {
    if (my !== session) return;
    console.error(e);
    loadError = e.message || "error";
    setConn(false);
    render();
  } finally {
    inflight = false;
  }
}

function setConn(ok) {
  const el = qs("#conn");
  if (!el) return;
  el.classList.toggle("err", !ok);
  el.textContent = ok ? "Diperbarui " + fmtClock(nowMs()) : "Gagal memuat, mencoba lagi...";
}

/* ===================== Render ===================== */
function decorate(r, now) {
  const ls = Number(r.lastSeen) || 0;
  const online = ls > 0 && Math.abs(now - ls) <= ONLINE_MS;
  return { r, code: r.code, name: deviceName(r), ls, online, banned: !!r.banned };
}

function matchesQuery(d) {
  if (!query) return true;
  const hay = [d.name, d.code, d.r.model, d.r.manufacturer, chipsetName(d.r)].join(" ").toLowerCase();
  return hay.indexOf(query) !== -1;
}

function matchesFilter(d) {
  if (filter === "online") return d.online;
  if (filter === "offline") return !d.online;
  if (filter === "banned") return d.banned;
  return true;
}

function cardHtml(d, now) {
  const r = d.r;
  const presence = d.online
    ? '<span class="badge online"><span class="dot"></span>Online</span>'
    : h(d.ls ? "Terakhir dilihat " + fmtDate(d.ls, now).replace(/^(Hari ini|Kemarin)/, m => m.toLowerCase()) : "Belum pernah terlihat");
  const banned = d.banned ? '<span class="badge banned">Banned</span>' : "";
  const btn = d.banned
    ? '<button class="btn ok sm" type="button" data-act="unban" data-code="' + h(d.code) + '">Unban</button>'
    : '<button class="btn danger sm" type="button" data-act="ban" data-code="' + h(d.code) + '">Ban</button>';
  return (
    '<div class="card-head">' +
      '<div class="ident"><h3 class="name">' + h(d.name) + '</h3>' +
      '<div class="code">ID <code>' + h(d.code) + '</code></div></div>' +
      '<div class="badges">' + banned + '</div>' +
    '</div>' +
    '<p class="presence">' + presence + '</p>' +
    '<dl class="specs">' +
      '<div><dt>Chipset</dt><dd>' + dash(chipsetName(r)) + '</dd></div>' +
      '<div><dt>RAM / Storage</dt><dd>' + h(fmtRam(r.totalRamMB)) + ' / ' + h(fmtStorage(r.totalStorageGB)) + '</dd></div>' +
      '<div><dt>Android</dt><dd>' + h(androidText(r)) + '</dd></div>' +
      '<div><dt>First seen</dt><dd>' + h(fmtDate(r.firstSeen, now)) + '</dd></div>' +
    '</dl>' +
    '<div class="card-foot">' + btn + '</div>'
  );
}

// Update list tanpa bongkar ulang: kartu dipakai ulang per kode device, innerHTML
// cuma diganti kalau isinya berubah, urutan DOM cuma digeser kalau perlu.
function reconcile(listEl, items) {
  const seen = new Set();
  let prev = null;
  for (const it of items) {
    seen.add(it.code);
    let rec = cards.get(it.code);
    if (!rec) {
      const el = document.createElement("article");
      el.dataset.code = it.code;
      rec = { el, html: null, cls: null };
      cards.set(it.code, rec);
    }
    if (rec.html !== it.html) { rec.el.innerHTML = it.html; rec.html = it.html; }
    if (rec.cls !== it.cls) { rec.el.className = it.cls; rec.cls = it.cls; }
    const expected = prev ? prev.nextElementSibling : listEl.firstElementChild;
    if (expected !== rec.el) listEl.insertBefore(rec.el, expected);
    prev = rec.el;
  }
  for (const [code, rec] of cards) {
    if (!seen.has(code)) { rec.el.remove(); cards.delete(code); }
  }
}

function render() {
  const listEl = qs("#list");
  if (!listEl) return;
  const now = nowMs();
  const all = devices.map(r => decorate(r, now));

  const onlineN = all.filter(d => d.online).length;
  const bannedN = all.filter(d => d.banned).length;
  setText("#st-total", all.length);
  setText("#st-online", onlineN);
  setText("#st-banned", bannedN);

  const shown = all.filter(d => matchesFilter(d) && matchesQuery(d));
  shown.sort((a, b) =>
    (Number(b.online) - Number(a.online)) ||
    (a.online ? a.name.localeCompare(b.name) : (b.ls - a.ls)) ||
    a.code.localeCompare(b.code)
  );

  reconcile(listEl, shown.map(d => ({
    code: d.code,
    cls: "card" + (d.banned ? " is-banned" : ""),
    html: cardHtml(d, now)
  })));

  const st = qs("#state");
  if (!loaded && !loadError) {
    st.hidden = false; st.className = "state"; st.textContent = "Memuat data...";
  } else if (!loaded && loadError) {
    st.hidden = false; st.className = "state err"; st.textContent = "Gagal memuat data: " + loadError;
  } else if (!all.length) {
    st.hidden = false; st.className = "state"; st.textContent = "Belum ada device.";
  } else if (!shown.length) {
    st.hidden = false; st.className = "state"; st.textContent = "Tidak ada device yang cocok.";
  } else {
    st.hidden = true;
  }
}

function setText(sel, v) {
  const el = qs(sel);
  const s = String(v);
  if (el && el.textContent !== s) el.textContent = s;
}

/* ===================== Modal ===================== */
let lastFocus = null;
let modalBusy = false;

function closeModal() {
  const root = qs("#modal-root");
  if (!root || !root.firstChild) return;
  root.innerHTML = "";
  document.body.classList.remove("modal-open");
  modalBusy = false;
  if (lastFocus && lastFocus.focus) { try { lastFocus.focus(); } catch (e) { /* abaikan */ } }
  lastFocus = null;
}

function openModal(cfg) {
  closeModal();
  lastFocus = document.activeElement;
  const root = qs("#modal-root");
  root.innerHTML =
    '<div class="backdrop"><div class="modal" role="dialog" aria-modal="true" aria-labelledby="m-title">' +
    '<h2 id="m-title">' + h(cfg.title) + '</h2>' + cfg.body +
    '<p class="m-err" id="m-err" hidden></p>' +
    '<div class="modal-actions">' +
      '<button class="btn ghost" type="button" id="m-cancel">Batal</button>' +
      '<button class="btn ' + cfg.cls + '" type="button" id="m-ok">' + h(cfg.okText) + '</button>' +
    '</div></div></div>';
  document.body.classList.add("modal-open");

  const ok = qs("#m-ok");
  const cancel = qs("#m-cancel");
  cancel.addEventListener("click", () => { if (!modalBusy) closeModal(); });
  ok.addEventListener("click", async () => {
    if (modalBusy) return;
    modalBusy = true;
    ok.disabled = true; cancel.disabled = true;
    ok.textContent = "Memproses...";
    qs("#m-err").hidden = true;
    try {
      await cfg.onConfirm();
      modalBusy = false;
      closeModal();
    } catch (e) {
      console.error(e);
      modalBusy = false;
      ok.disabled = false; cancel.disabled = false;
      ok.textContent = cfg.okText;
      const err = qs("#m-err");
      err.textContent = "Gagal: " + (e.message || "error") + ". Coba lagi.";
      err.hidden = false;
    }
  });
  const first = qs("#m-msg") || ok;
  first.focus();
}

document.addEventListener("keydown", e => {
  if (e.key === "Escape" && !modalBusy) closeModal();
});

document.addEventListener("click", e => {
  const bd = e.target;
  if (bd && bd.classList && bd.classList.contains("backdrop") && !modalBusy) closeModal();
});

function findDevice(code) { return devices.find(d => d.code === code); }

function openBan(code) {
  const d = findDevice(code);
  const name = d ? deviceName(d) : code;
  openModal({
    title: "Ban device",
    cls: "danger",
    okText: "Ban",
    body:
      '<p>Ban <strong>' + h(name) + '</strong> (ID <code>' + h(code) + '</code>)? Device akan langsung terkunci saat ujian.</p>' +
      '<label class="field"><span>Pesan ban (opsional)</span>' +
      '<textarea class="input" id="m-msg" rows="3" maxlength="300" placeholder="Kosongkan untuk pakai pesan default"></textarea></label>',
    onConfirm: async () => {
      const message = qs("#m-msg").value.trim();
      await jf(BANS + "/" + encodeURIComponent(code) + ".json", {
        method: "PUT",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ banned: true, message })
      });
      if (d) d.banned = true;
      render();
      refresh();
    }
  });
}

function openUnban(code) {
  const d = findDevice(code);
  const name = d ? deviceName(d) : code;
  openModal({
    title: "Unban device",
    cls: "ok",
    okText: "Unban",
    body: '<p>Unban <strong>' + h(name) + '</strong> (ID <code>' + h(code) + '</code>)? Device bisa dipakai ujian lagi.</p>',
    onConfirm: async () => {
      await jf(BANS + "/" + encodeURIComponent(code) + ".json", { method: "DELETE" });
      if (d) d.banned = false;
      render();
      refresh();
    }
  });
}

/* ===================== Theme ===================== */
function toggleTheme() {
  const cur = document.documentElement.getAttribute("data-theme") === "dark" ? "dark" : "light";
  const next = cur === "dark" ? "light" : "dark";
  document.documentElement.setAttribute("data-theme", next);
  store.set(THEME_KEY, next);
}

/* ===================== Screens ===================== */
const ICON_SHIELD = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l8 3v6c0 4.5-3.2 8.2-8 9-4.8-.8-8-4.5-8-9V6l8-3z"/><path d="M9 12l2 2 4-4"/></svg>';
const ICON_SEARCH = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/></svg>';
const ICON_SUN = '<svg class="sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>';
const ICON_MOON = '<svg class="moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.8A9 9 0 1111.2 3a7 7 0 009.8 9.8z"/></svg>';
const ICON_LOGOUT = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><path d="M16 17l5-5-5-5M21 12H9"/></svg>';

function stopPolling() {
  clearInterval(pollTimer); clearInterval(tickTimer);
  pollTimer = null; tickTimer = null;
}

function showDash() {
  session++;
  devices = []; loaded = false; loadError = ""; inflight = false;
  cards.clear();
  stopPolling();

  qs("#app").innerHTML =
    '<header class="topbar"><div class="topbar-in">' +
      '<div class="brand"><div class="brand-mark">' + ICON_SHIELD + '</div>' +
      '<div class="brand-text"><strong>UjianBrowser</strong><small>Admin Dashboard</small></div></div>' +
      '<div class="top-actions">' +
        '<span class="conn" id="conn"></span>' +
        '<button class="btn ghost icon-btn" type="button" id="theme" aria-label="Ganti tema" title="Ganti tema">' + ICON_SUN + ICON_MOON + '</button>' +
        '<button class="btn ghost logout" type="button" id="logout">' + ICON_LOGOUT + '<span class="lbl">Logout</span></button>' +
      '</div>' +
    '</div></header>' +
    '<main class="page">' +
      '<section class="stats">' +
        '<div class="stat"><div class="label">Total device</div><div class="value" id="st-total">0</div></div>' +
        '<div class="stat s-online"><div class="label">Online</div><div class="value" id="st-online">0</div></div>' +
        '<div class="stat s-banned"><div class="label">Banned</div><div class="value" id="st-banned">0</div></div>' +
      '</section>' +
      '<section class="toolbar">' +
        '<label class="search">' + ICON_SEARCH + '<input class="input" id="q" type="search" placeholder="Cari nama, ID, atau chipset" autocomplete="off"></label>' +
        '<div class="seg" role="group" aria-label="Filter status">' +
          '<button type="button" data-filter="all" aria-pressed="true">Semua</button>' +
          '<button type="button" data-filter="online" aria-pressed="false">Online</button>' +
          '<button type="button" data-filter="offline" aria-pressed="false">Offline</button>' +
          '<button type="button" data-filter="banned" aria-pressed="false">Banned</button>' +
        '</div>' +
      '</section>' +
      '<div class="list" id="list"></div>' +
      '<div class="state" id="state">Memuat data...</div>' +
    '</main>';

  filter = "all"; query = "";

  qs("#theme").addEventListener("click", toggleTheme);
  qs("#logout").addEventListener("click", logout);
  qs("#q").addEventListener("input", e => { query = e.target.value.trim().toLowerCase(); render(); });
  qs(".seg").addEventListener("click", e => {
    const b = e.target.closest("button[data-filter]");
    if (!b) return;
    filter = b.dataset.filter;
    document.querySelectorAll(".seg button").forEach(x => x.setAttribute("aria-pressed", String(x === b)));
    render();
  });
  qs("#list").addEventListener("click", e => {
    const b = e.target.closest("button[data-act]");
    if (!b) return;
    if (b.dataset.act === "ban") openBan(b.dataset.code); else openUnban(b.dataset.code);
  });

  render();
  refresh();
  pollTimer = setInterval(refresh, REFRESH_MS);
  tickTimer = setInterval(render, 1000); // update status Online/"Terakhir dilihat" tanpa fetch
}

function showLogin() {
  session++;
  stopPolling();
  closeModal();
  qs("#app").innerHTML =
    '<div class="login-wrap"><form class="login-card" id="login" autocomplete="on">' +
      '<div class="brand-mark">' + ICON_SHIELD + '</div>' +
      '<h1>Admin Dashboard</h1><p class="sub">UjianBrowser. Masukkan password untuk melanjutkan.</p>' +
      '<label class="field"><span>Password</span>' +
      '<input class="input" id="pw" type="password" autocomplete="current-password" required></label>' +
      '<p class="form-err" id="login-err" hidden>Password salah.</p>' +
      '<button class="btn" type="submit">Masuk</button>' +
    '</form></div>';
  qs("#login").addEventListener("submit", e => {
    e.preventDefault();
    if (qs("#pw").value !== PASSWORD) {
      qs("#login-err").hidden = false;
      qs("#pw").select();
      return;
    }
    store.set(AUTH_KEY, hashPw(PASSWORD));
    showDash();
  });
  qs("#pw").focus();
}

function logout() {
  store.del(AUTH_KEY);
  showLogin();
}

document.addEventListener("visibilitychange", () => { if (!document.hidden && qs("#list")) refresh(); });

function init() { if (isAuthed()) showDash(); else showLogin(); }
if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
