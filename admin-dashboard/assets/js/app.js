(function () {
"use strict";

// iOS Safari baru memicu :active kalau ada listener sentuhan di dokumen
document.addEventListener("touchstart", function () {}, { passive: true });

// Feedback tap: flash + ring memudar di tombol, getar halus di HP yang mendukung
document.addEventListener("pointerdown", function (e) {
  const b = e.target.closest && e.target.closest("button");
  if (!b || b.disabled) return;
  b.classList.remove("tap-fx");
  void b.offsetWidth;
  b.classList.add("tap-fx");
  if (e.pointerType === "touch" && navigator.vibrate) { try { navigator.vibrate(10); } catch (err) { /* abaikan */ } }
}, true);
document.addEventListener("animationend", function (e) {
  if (e.animationName === "tapfx") e.target.classList.remove("tap-fx");
}, true);

/* ===================== Config ===================== */
const ROOT = "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app";
const BASE = ROOT + "/devices";
const BANS = ROOT + "/banned";
const OWNERS = ROOT + "/owners";
const BAN_HISTORY = ROOT + "/ban_history";
const PASSWORD = "banned";
const AUTH_HEADER = "Basic YWRtaW46YWRtaW4=";

const AUTH_KEY = "ujian_admin_auth";
const THEME_KEY = "ujian_admin_theme";
const ONLINE_MS = 10000;   // now - lastSeen <= 10 detik => Online
const REFRESH_MS = 4000;   // ambil data baru tiap 4 detik
const TZ = "Asia/Jakarta";
const SESSION_MS = 24 * 60 * 60 * 1000; // sesi login berlaku 1 hari

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
// Sesi login disimpan di localStorage dan kedaluwarsa setelah 1 hari.
function saveAuth() { store.set(AUTH_KEY, JSON.stringify({ h: hashPw(PASSWORD), t: Date.now() })); }
function isAuthed() {
  const raw = store.get(AUTH_KEY);
  if (!raw) return false;
  try {
    const a = JSON.parse(raw);
    const age = Date.now() - Number(a.t);
    return a.h === hashPw(PASSWORD) && age >= 0 && age < SESSION_MS;
  } catch (e) { return false; }
}

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
  if (valid(r.gsmaName)) return String(r.gsmaName).trim();
  const model = valid(r.model) ? String(r.model).trim() : "";
  let maker = valid(r.manufacturer) ? String(r.manufacturer).trim() : "";
  if (maker) maker = maker.charAt(0).toUpperCase() + maker.slice(1);
  let name = model;
  if (maker && !model.toLowerCase().startsWith(maker.toLowerCase())) name = (maker + " " + model).trim();
  return name || "Device tanpa nama";
}

function deviceImage(r) {
  return valid(r.gsmaImage) ? String(r.gsmaImage).trim() : "";
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

function fmtBattery(r) {
  const raw = r.batteryPct;
  const p = Number(raw);
  if (raw === undefined || raw === null || raw === "" || !isFinite(p) || p < 0) {
    return { has: false, pct: 0, cls: "none", label: "Belum ada data" };
  }
  const pct = Math.max(0, Math.min(100, Math.round(p)));
  const st = Number(r.batteryStatus);
  const pl = Number(r.batteryPlugged) || 0;
  const src = pl & 4 ? "Nirkabel" : pl & 2 ? "USB" : pl & 1 ? "AC" : "";
  const via = src ? " \u00b7 " + src : "";
  let label, cls = "";
  if (st === 2) { label = "Sedang dicas" + via; cls = "charging"; }
  else if (st === 5) { label = "Penuh" + via; cls = "charging"; }
  else if (pl && st === 4) { label = "Terhubung, tidak mengisi" + via; }
  else { label = "Tidak dicas"; if (pct <= 15) cls = "low"; }
  return { has: true, pct, cls, label };
}

const RING_C = 2 * Math.PI * 27;
function ringHtml(r, online) {
  const b = fmtBattery(r);
  const dash = (RING_C * b.pct / 100).toFixed(1) + " " + RING_C.toFixed(1);
  const sub = b.has && !online ? '<div class="ring-sub">data terakhir</div>' : "";
  return '<div class="ring-wrap">' +
    '<div class="ring ' + b.cls + '" role="img" aria-label="' + h(b.has ? "Baterai " + b.pct + " persen, " + b.label : "Data baterai belum ada") + '">' +
      '<svg viewBox="0 0 64 64" aria-hidden="true"><circle class="track" cx="32" cy="32" r="27"/>' +
      '<circle class="arc" cx="32" cy="32" r="27" stroke-dasharray="' + dash + '"/></svg>' +
      '<span class="pct">' + (b.has ? b.pct + "%" : "-") + '</span>' +
    '</div>' +
    '<div class="ring-label ' + b.cls + '">' + h(b.label) + '</div>' + sub +
  '</div>';
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
let gridMode = store.get("ujian_admin_grid") === "1";  // tampilan kartu: false = 1 per baris, true = 2 kolom
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
  if (!isAuthed()) { showLogin(); return; } // sesi 1 hari habis
  const my = session;
  inflight = true;
  try {
    const [devs, bans, owners] = await Promise.all([jf(BASE + ".json"), jf(BANS + ".json"), jf(OWNERS + ".json").catch(() => ({}))]);
    if (my !== session) return;
    const ownerMap = owners && typeof owners === "object" ? owners : {};
    const banMap = bans && typeof bans === "object" ? bans : {};
    devices = Object.entries(devs || {}).map(([code, v]) => {
      const ban = banMap[code];
      const banMsg = ban && typeof ban === "object" && typeof ban.message === "string" ? ban.message : "";
      return Object.assign({}, v && typeof v === "object" ? v : {}, { code, banned: isBanned(ban), banMsg, owner: typeof ownerMap[code] === "string" ? ownerMap[code] : "" });
    });
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

let connOk = true;
// Jam live: diperbarui tiap detik oleh tick, bukan cuma pas fetch (fetch tiap 4 dtk bikin angka loncat)
function renderConn() {
  const el = qs("#conn");
  if (!el) return;
  el.classList.toggle("err", !connOk);
  if (!el.firstChild) el.innerHTML = '<span class="live-dot"></span><span class="conn-text"></span>';
  el.lastChild.textContent = connOk ? "Live \u00b7 " + fmtClock(nowMs()) : "Gagal memuat, mencoba lagi...";
}
function setConn(ok) { connOk = ok; renderConn(); }

/* ===================== Render ===================== */
function decorate(r, now) {
  const ls = Number(r.lastSeen) || 0;
  const online = ls > 0 && Math.abs(now - ls) <= ONLINE_MS;
  return { r, code: r.code, name: deviceName(r), image: deviceImage(r), owner: r.owner || "", ls, online, banned: !!r.banned, banMsg: r.banMsg || "" };
}

function matchesQuery(d) {
  if (!query) return true;
  const hay = [d.name, d.owner, d.code, d.r.model, d.r.manufacturer, chipsetName(d.r)].join(" ").toLowerCase();
  return hay.indexOf(query) !== -1;
}

function matchesFilter(d) {
  if (filter === "online") return d.online;
  if (filter === "offline") return !d.online;
  if (filter === "banned") return d.banned;
  return true;
}

function copyId(btn) {
  const text = btn.dataset.code || "";
  const done = function () {
    btn.innerHTML = ICON_CHECK;
    btn.classList.add("copied");
    clearTimeout(btn._t);
    btn._t = setTimeout(function () { btn.innerHTML = ICON_COPY; btn.classList.remove("copied"); }, 1200);
  };
  if (navigator.clipboard && navigator.clipboard.writeText) {
    navigator.clipboard.writeText(text).then(done, function () { fallbackCopy(text) && done(); });
  } else if (fallbackCopy(text)) {
    done();
  }
}

function fallbackCopy(text) {
  try {
    const ta = document.createElement("textarea");
    ta.value = text; ta.setAttribute("readonly", "");
    ta.style.cssText = "position:fixed;top:0;left:0;opacity:0";
    document.body.appendChild(ta); ta.select();
    const ok = document.execCommand("copy");
    ta.remove();
    return ok;
  } catch (e) { return false; }
}

// Kartu mode grid: baterai jadi "air" bergelombang di belakang angka persen.
const WAVE_D = "M0 10 Q25 0 50 10 T100 10 T150 10 T200 10 V20 H0Z";
function battIcon(pct) {
  const w = pct <= 0 ? 0 : Math.max(1.5, 16 * pct / 100);
  return '<svg class="g-bi" viewBox="0 0 26 14" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" aria-hidden="true">' +
    '<rect x="1" y="1" width="21" height="12" rx="3.2"/><path d="M24.5 5v4"/>' +
    (w ? '<rect x="3.5" y="3.5" width="' + w.toFixed(1) + '" height="7" rx="1.4" fill="currentColor" stroke="none"/>' : "") +
    '</svg>';
}

function gridCardHtml(d, now) {
  const r = d.r;
  const b = fmtBattery(r);
  let tone;
  if (d.banned) tone = "ban";
  else if (!b.has) tone = "none";
  else if (!d.online) tone = b.cls === "low" ? "low" : "off";
  else tone = b.cls === "charging" ? "chg" : b.cls === "low" ? "low" : "on";
  const water = b.has
    ? '<div class="g-water" style="height:' + (b.pct === 0 ? 0 : Math.max(8, Math.min(88, b.pct))) + '%">' +
        '<svg class="g-wave w2" viewBox="0 0 200 20" preserveAspectRatio="none" aria-hidden="true"><path d="' + WAVE_D + '"/></svg>' +
        '<svg class="g-wave" viewBox="0 0 200 20" preserveAspectRatio="none" aria-hidden="true"><path d="' + WAVE_D + '"/></svg>' +
      '</div>'
    : "";
  const status = d.banned ? ICON_LOCK + "Banned" : '<span class="gd"></span>' + (d.online ? "Online" : "Offline");
  const sub = d.online
    ? (b.has ? b.label : "Belum ada data baterai")
    : (d.ls ? "Terlihat " + fmtDate(d.ls, now).replace(/^(Hari ini|Kemarin)/, m => m.toLowerCase()) : "Belum pernah terlihat");
  const code = h(d.code);
  const quote = d.banned
    ? '<button class="g-q' + (d.banMsg ? '' : ' empty') + '" type="button" data-act="banmsg" data-code="' + code + '" aria-label="Edit pesan ban" title="Edit pesan ban">' +
      h(d.banMsg ? "\u201c" + d.banMsg + "\u201d" : "Tanpa pesan custom") + '</button>'
    : "";
  const act = d.banned
    ? '<button class="un" type="button" data-act="unban" data-code="' + code + '" aria-label="Unban perangkat" title="Unban perangkat">' + ICON_CHECK + '</button>'
    : '<button class="bn" type="button" data-act="ban" data-code="' + code + '" aria-label="Ban perangkat" title="Ban perangkat">' + ICON_BAN + '</button>';
  return (
    '<div class="g-hero ' + tone + '">' + water +
      '<div class="g-pct">' + (b.has ? battIcon(b.pct) + b.pct + '<small>%</small>' + (b.cls === "charging" ? ICON_BOLT : "") : "\u2013") + '</div>' +
      '<div class="g-st">' + status + '</div>' +
      '<div class="g-sub">' + h(sub) + '</div>' +
    '</div>' +
    '<div class="g-bd">' +
      '<div class="g-title">' + (d.image ? '<img class="device-thumb g-thumb" src="' + h(d.image) + '" alt="' + h(d.name) + '" loading="lazy" decoding="async" referrerpolicy="no-referrer" onerror="this.style.visibility=\'hidden\'">' : "") +
      '<h3 class="name">' + h(d.name) + '</h3></div>' +
      '<button class="g-owner' + (d.owner ? '' : ' empty') + '" type="button" data-act="owner" data-code="' + code + '" aria-label="Edit label pemilik" title="Edit label pemilik">' + ICON_USER + '<span>' + h(d.owner || "Tambah label") + '</span>' + ICON_PENCIL + '</button>' +
      quote +
      '<div class="g-id"><span class="id-chip"><code>' + code + '</code>' +
        '<button class="copy-btn" type="button" data-act="copy" data-code="' + code + '" aria-label="Salin ID" title="Salin ID">' + ICON_COPY + '</button></span></div>' +
    '</div>' +
    '<div class="g-ac">' +
      '<button type="button" data-act="history" data-code="' + code + '" aria-label="Riwayat pesan ban" title="Riwayat pesan ban">' + ICON_HISTORY + '</button>' +
      act +
    '</div>'
  );
}

function cardHtml(d, now) {
  if (gridMode) return gridCardHtml(d, now);
  const r = d.r;
  const presence = d.online
    ? '<span class="badge online"><span class="dot"></span>Online</span>'
    : '<span>' + h(d.ls ? "Terakhir dilihat " + fmtDate(d.ls, now).replace(/^(Hari ini|Kemarin)/, m => m.toLowerCase()) : "Belum pernah terlihat") + '</span>';
  const banned = d.banned ? '<span class="badge banned">Banned</span>' : "";
  const banMsgChip = d.banned
    ? '<button class="ban-msg-chip' + (d.banMsg ? '' : ' empty') + '" type="button" data-act="banmsg" data-code="' + h(d.code) + '" aria-label="Edit pesan ban" title="Edit pesan ban">' +
      ICON_PENCIL + '<span>' + h(d.banMsg || "Tanpa pesan custom") + '</span></button>'
    : '';
  const btn = d.banned
    ? '<button class="btn ok" type="button" data-act="unban" data-code="' + h(d.code) + '">Unban perangkat</button>'
    : '<button class="btn soft-danger" type="button" data-act="ban" data-code="' + h(d.code) + '">Ban perangkat</button>';
  return (
    '<div class="card-head">' +
      '<div class="ident-wrap">' + (d.image ? '<img class="device-thumb" src="' + h(d.image) + '" alt="' + h(d.name) + '" loading="lazy" decoding="async" referrerpolicy="no-referrer" onerror="this.style.visibility=\'hidden\'">' : "") +
      '<div class="ident"><div class="name-row"><h3 class="name">' + h(d.name) + '</h3>' +
      '<button class="owner-chip' + (d.owner ? '' : ' empty') + '" type="button" data-act="owner" data-code="' + h(d.code) + '" aria-label="Edit label pemilik" title="Edit label pemilik">' +
      ICON_PENCIL + '<span>' + h(d.owner || "Label") + '</span></button></div>' +
      '<div class="code">ID <span class="id-chip"><code>' + h(d.code) + '</code>' +
      '<button class="copy-btn" type="button" data-act="copy" data-code="' + h(d.code) + '" aria-label="Salin ID" title="Salin ID">' + ICON_COPY + '</button></span></div>' +
      '<p class="presence">' + presence + banned + '</p>' +
      (d.banned ? '<p class="ban-msg-row">' + banMsgChip + '</p>' : '') +
      '</div></div>' +
      ringHtml(r, d.online) +
    '</div>' +
    '<dl class="specs">' +
      '<div><dt>Chipset</dt><dd>' + dash(chipsetName(r)) + '</dd></div>' +
      '<div><dt>RAM / Storage</dt><dd>' + h(fmtRam(r.totalRamMB)) + ' / ' + h(fmtStorage(r.totalStorageGB)) + '</dd></div>' +
      '<div><dt>Android</dt><dd>' + h(androidText(r)) + '</dd></div>' +
      '<div><dt>Pertama terlihat</dt><dd>' + h(fmtDate(r.firstSeen, now)) + '</dd></div>' +
    '</dl>' +
    '<div class="card-foot">' + btn +
      '<button class="btn hist-btn" type="button" data-act="history" data-code="' + h(d.code) + '" aria-label="Riwayat pesan ban" title="Riwayat pesan ban">' + ICON_HISTORY + '</button></div>'
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
  setText("#ct-all", "(" + all.length + ")");
  setText("#ct-online", "(" + onlineN + ")");
  setText("#ct-offline", "(" + (all.length - onlineN) + ")");
  setText("#ct-banned", "(" + bannedN + ")");

  const shown = all.filter(d => matchesFilter(d) && matchesQuery(d));
  shown.sort((a, b) =>
    (Number(b.online) - Number(a.online)) ||
    (a.online ? a.name.localeCompare(b.name) : (b.ls - a.ls)) ||
    a.code.localeCompare(b.code)
  );

  reconcile(listEl, shown.map(d => ({
    code: d.code,
    cls: "card" + (d.banned ? " is-banned" : "") + (gridMode ? " g-card" : ""),
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

// Modal ikut ukuran viewport visual: waktu keyboard HP muncul, backdrop menyusut ke area
// di atas keyboard sehingga modal selalu kelihatan dan menempel di atasnya.
let vvHandler = null;
function bindViewport() {
  const vv = window.visualViewport;
  if (!vv) return;
  vvHandler = function () {
    const bd = qs(".backdrop");
    if (!bd) return;
    bd.style.top = vv.offsetTop + "px";
    bd.style.left = vv.offsetLeft + "px";
    bd.style.width = vv.width + "px";
    bd.style.height = vv.height + "px";
  };
  vv.addEventListener("resize", vvHandler);
  vv.addEventListener("scroll", vvHandler);
  vvHandler();
}
function unbindViewport() {
  const vv = window.visualViewport;
  if (vv && vvHandler) {
    vv.removeEventListener("resize", vvHandler);
    vv.removeEventListener("scroll", vvHandler);
  }
  vvHandler = null;
}

function closeModal() {
  const root = qs("#modal-root");
  if (!root || !root.firstChild) return;
  unbindViewport();
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
    '<div class="backdrop' + (cfg.center ? ' center' : '') + '"><div class="modal' + (cfg.center ? ' center' : '') + (cfg.noCancel ? ' single' : '') + '" role="dialog" aria-modal="true" aria-labelledby="m-title">' +
    '<h2 id="m-title">' + h(cfg.title) + '</h2>' + cfg.body +
    '<p class="m-err" id="m-err" hidden></p>' +
    '<div class="modal-actions">' +
      '<button class="btn ghost" type="button" id="m-cancel"' + (cfg.noCancel ? ' hidden' : '') + '>Batal</button>' +
      '<button class="btn ' + cfg.cls + '" type="button" id="m-ok">' + h(cfg.okText) + '</button>' +
    '</div></div></div>';
  document.body.classList.add("modal-open");
  bindViewport();

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
      await logBanMsg(code, message, "ban");
      if (d) d.banned = true;
      render();
      refresh();
    }
  });
}

function openOwner(code) {
  const d = findDevice(code);
  const name = d ? deviceName(d) : code;
  openModal({
    title: "Label pemilik",
    cls: "ok",
    okText: "Simpan",
    body:
      '<p>Label untuk <strong>' + h(name) + '</strong> (ID <code>' + h(code) + '</code>).</p>' +
      '<label class="field"><span>Nama pemilik</span>' +
      '<input class="input" id="m-msg" type="text" maxlength="40" value="' + h(d ? d.owner : "") + '" placeholder="Kosongkan untuk hapus label"></label>',
    onConfirm: async () => {
      const label = qs("#m-msg").value.trim().slice(0, 40);
      const url = OWNERS + "/" + encodeURIComponent(code) + ".json";
      if (label) {
        await jf(url, { method: "PUT", headers: { "Content-Type": "application/json; charset=utf-8" }, body: JSON.stringify(label) });
      } else {
        await jf(url, { method: "DELETE" });
      }
      if (d) d.owner = label;
      render();
      refresh();
    }
  });
}

function openBanMsg(code) {
  const d = findDevice(code);
  const name = d ? deviceName(d) : code;
  openModal({
    title: "Pesan ban",
    cls: "ok",
    okText: "Simpan",
    body:
      '<p>Pesan ban untuk <strong>' + h(name) + '</strong> (ID <code>' + h(code) + '</code>).</p>' +
      '<label class="field"><span>Pesan ban</span>' +
      '<textarea class="input" id="m-msg" rows="3" maxlength="300" placeholder="Kosongkan untuk pakai pesan default">' + h(d ? d.banMsg : "") + '</textarea></label>',
    onConfirm: async () => {
      const message = qs("#m-msg").value.trim();
      await jf(BANS + "/" + encodeURIComponent(code) + ".json", {
        method: "PUT",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ banned: true, message })
      });
      if (!d || d.banMsg !== message) await logBanMsg(code, message, "edit");
      if (d) d.banMsg = message;
      render();
      refresh();
    }
  });
}

// Riwayat pesan ban custom: /ban_history/{kode}/{pushId} = { message, at, type }
// Dicatat cuma kalau pesannya diisi; gagal nyatet tidak membatalkan ban-nya.
async function logBanMsg(code, message, type) {
  if (!message) return;
  try {
    await jf(BAN_HISTORY + "/" + encodeURIComponent(code) + ".json", {
      method: "POST",
      headers: { "Content-Type": "application/json; charset=utf-8" },
      body: JSON.stringify({ message, at: nowMs(), type })
    });
  } catch (e) { console.error("riwayat pesan ban gagal dicatat", e); }
}

async function openHistory(code) {
  const d = findDevice(code);
  const name = d ? deviceName(d) : code;
  openModal({
    title: "Riwayat pesan ban",
    center: true,
    cls: "ok",
    okText: "Tutup",
    noCancel: true,
    body:
      '<p>Pesan ban custom untuk <strong>' + h(name) + '</strong> (ID <code>' + h(code) + '</code>).</p>' +
      '<div class="hist-list" id="m-hist"><p class="hist-empty">Memuat...</p></div>',
    onConfirm: async () => {}
  });
  let items = [];
  let failed = false;
  try {
    const data = await jf(BAN_HISTORY + "/" + encodeURIComponent(code) + ".json");
    if (data && typeof data === "object") {
      items = Object.values(data).filter(x => x && typeof x.message === "string");
    }
  } catch (e) { failed = true; }
  const box = qs("#m-hist");
  if (!box) return; // modal sudah ditutup
  items.sort((a, b) => (Number(b.at) || 0) - (Number(a.at) || 0));
  const now = nowMs();
  let html = "";
  if (d && d.banned && d.banMsg) {
    html += '<div class="hist-item now"><div class="hist-meta"><span class="hist-tag now">Aktif sekarang</span></div>' +
      '<div class="hist-msg">' + h(d.banMsg) + '</div></div>';
  }
  html += items.map(x =>
    '<div class="hist-item"><div class="hist-meta"><span class="hist-tag">' + (x.type === "edit" ? "Diedit" : "Ban") + '</span>' +
    '<span>' + h(fmtDate(x.at, now)) + '</span></div><div class="hist-msg">' + h(x.message) + '</div></div>'
  ).join("");
  if (!html) html = '<p class="hist-empty">' + (failed ? "Gagal memuat riwayat." : "Belum ada riwayat pesan custom.") + '</p>';
  box.innerHTML = html;
}

function openUnban(code) {
  const d = findDevice(code);
  const name = d ? deviceName(d) : code;
  openModal({
    title: "Unban device",
    center: true,
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
const ICON_PENCIL = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 20h4L19 9a2.8 2.8 0 0 0-4-4L4 16z"/><path d="M13.5 6.5l4 4"/></svg>';
const ICON_SHIELD = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l8 3v6c0 4.5-3.2 8.2-8 9-4.8-.8-8-4.5-8-9V6l8-3z"/><path d="M9 12l2 2 4-4"/></svg>';
const ICON_SEARCH = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/></svg>';
const ICON_SUN = '<svg class="sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>';
const ICON_MOON = '<svg class="moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.8A9 9 0 1111.2 3a7 7 0 009.8 9.8z"/></svg>';
const ICON_GRID = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7.5" height="7.5" rx="1.5"/><rect x="13.5" y="3" width="7.5" height="7.5" rx="1.5"/><rect x="3" y="13.5" width="7.5" height="7.5" rx="1.5"/><rect x="13.5" y="13.5" width="7.5" height="7.5" rx="1.5"/></svg>';
const ICON_COPY = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="11" height="11" rx="2"/><path d="M5 15V6a2 2 0 012-2h9"/></svg>';
const ICON_CHECK = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12.5l4.5 4.5L19 7.5"/></svg>';
const ICON_HISTORY = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.5 2"/></svg>';
const ICON_USER = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="8" r="4"/><path d="M4 20.5c0-4 3.6-6.5 8-6.5s8 2.5 8 6.5"/></svg>';
const ICON_BAN = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M5.6 5.6l12.8 12.8"/></svg>';
const ICON_LOCK = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"/><path d="M8 11V8a4 4 0 018 0v3"/></svg>';
const ICON_BOLT = '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M13 2 4 14h6l-1 8 9-12h-6z"/></svg>';
const ICON_LOGOUT = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><path d="M16 17l5-5-5-5M21 12H9"/></svg>';

const ICON_EYE = '<svg class="eye" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z"/><circle cx="12" cy="12" r="3"/></svg>';
const ICON_EYE_OFF = '<svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.9 17.9A10.9 10.9 0 0112 19C5 19 1 12 1 12a18.5 18.5 0 015.1-5.9M9.9 5.1A10.4 10.4 0 0112 5c7 0 11 7 11 7a18.5 18.5 0 01-2.2 3.2M14.1 14.1a3 3 0 11-4.2-4.2"/><path d="M1 1l22 22"/></svg>';

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
      '<div class="brand-text"><strong>List Device</strong><span class="conn" id="conn"></span></div>' +
      '<div class="top-actions">' +
        '<button class="btn icon-btn sq" type="button" id="grid" aria-label="Mode grid" aria-pressed="' + gridMode + '" title="Mode grid">' + ICON_GRID + '</button>' +
        '<button class="btn icon-btn sq" type="button" id="theme" aria-label="Ganti tema" title="Ganti tema">' + ICON_SUN + ICON_MOON + '</button>' +
        '<button class="btn icon-btn sq logout" type="button" id="logout" aria-label="Logout" title="Logout">' + ICON_LOGOUT + '</button>' +
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
          '<button type="button" data-filter="all" aria-pressed="true">Semua<span class="cnt" id="ct-all">(0)</span></button>' +
          '<button type="button" data-filter="online" aria-pressed="false">Online<span class="cnt" id="ct-online">(0)</span></button>' +
          '<button type="button" data-filter="offline" aria-pressed="false">Offline<span class="cnt" id="ct-offline">(0)</span></button>' +
          '<button type="button" data-filter="banned" aria-pressed="false">Banned<span class="cnt" id="ct-banned">(0)</span></button>' +
        '</div>' +
      '</section>' +
      '<div class="list' + (gridMode ? ' grid2' : '') + '" id="list"></div>' +
      '<div class="state" id="state">Memuat data...</div>' +
    '</main>';

  filter = "all"; query = "";

  qs("#grid").addEventListener("click", function () {
    gridMode = !gridMode;
    store.set("ujian_admin_grid", gridMode ? "1" : "0");
    this.setAttribute("aria-pressed", String(gridMode));
    qs("#list").classList.toggle("grid2", gridMode);
    render();
  });
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
    if (b.dataset.act === "copy") copyId(b);
    else if (b.dataset.act === "owner") openOwner(b.dataset.code);
    else if (b.dataset.act === "ban") openBan(b.dataset.code);
    else if (b.dataset.act === "banmsg") openBanMsg(b.dataset.code);
    else if (b.dataset.act === "history") openHistory(b.dataset.code);
    else openUnban(b.dataset.code);
  });

  render();
  refresh();
  pollTimer = setInterval(refresh, REFRESH_MS);
  tickTimer = setInterval(function () { renderConn(); render(); }, 1000); // update status Online/"Terakhir dilihat" tanpa fetch
}

function showLogin() {
  session++;
  stopPolling();
  closeModal();
  qs("#app").innerHTML =
    '<div class="login-wrap"><form class="login-card" id="login" autocomplete="on">' +
      '<div class="brand-mark">' + ICON_SHIELD + '</div>' +
      '<h1>Admin Dashboard</h1><p class="sub">UjianBrowser. Masukkan password untuk melanjutkan.</p>' +
      '<label class="field" for="pw"><span>Password</span></label>' +
      '<div class="pw-wrap">' +
        '<input class="input" id="pw" type="password" autocomplete="current-password" required>' +
        '<button class="pw-toggle" type="button" id="pw-toggle" aria-label="Tampilkan password" aria-pressed="false" title="Tampilkan password">' + ICON_EYE + ICON_EYE_OFF + '</button>' +
      '</div>' +
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
    saveAuth();
    showDash();
  });
  qs("#pw-toggle").addEventListener("click", () => {
    const pw = qs("#pw");
    const show = pw.type === "password";
    pw.type = show ? "text" : "password";
    const t = qs("#pw-toggle");
    t.setAttribute("aria-pressed", String(show));
    t.setAttribute("aria-label", show ? "Sembunyikan password" : "Tampilkan password");
    t.title = show ? "Sembunyikan password" : "Tampilkan password";
    pw.focus();
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
