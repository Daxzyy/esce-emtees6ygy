const ROOT = "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app";
const BASE = ROOT + "/devices";
const BANS = ROOT + "/banned";
const PASSWORD = "banned";
const AUTH_HEADER = "Basic YWRtaW46YWRtaW4=";

function qs(sel) { return document.querySelector(sel); }

function esc(v) {
  const s = v === undefined || v === null || v === "" ? "-" : String(v);
  return s.replace(/[&<>"']/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
}

function fmtDate(ts) {
  if (!ts) return "-";
  const d = new Date(Number(ts));
  return isNaN(d) ? "-" : d.toLocaleString("id-ID", { timeZone: "Asia/Jakarta" });
}

async function jf(u, opts) {
  const o = opts || {};
  const r = await fetch(u, { ...o, headers: { "Authorization": AUTH_HEADER, ...(o.headers || {}) } });
  if (!r.ok) throw new Error("HTTP " + r.status);
  return r.json();
}

function valid(v) {
  return v !== undefined && v !== null && String(v).trim() !== "" && String(v).trim() !== "Tidak diketahui";
}

// Nama device lengkap: "Samsung SM-A135F" (+ nama bawaan HP kalau ada, mis. "Galaxy A13")
function deviceName(r) {
  let maker = valid(r.manufacturer) ? String(r.manufacturer).trim() : "";
  const model = valid(r.model) ? String(r.model).trim() : "";
  if (maker) maker = maker.charAt(0).toUpperCase() + maker.slice(1);
  let name = model;
  if (maker && !model.toLowerCase().startsWith(maker.toLowerCase())) name = (maker + " " + model).trim();
  if (!name) name = "-";
  if (valid(r.deviceName) && String(r.deviceName).trim().toLowerCase() !== model.toLowerCase() &&
      !name.toLowerCase().includes(String(r.deviceName).trim().toLowerCase())) {
    name += " (" + String(r.deviceName).trim() + ")";
  }
  return name;
}

// Chipset: pakai hasil dari app; kalau "Tidak diketahui" jatuh ke socModel / hardware mentah
function chipsetName(r) {
  if (valid(r.chipset)) return r.chipset;
  if (valid(r.socModel)) return r.socModel;
  if (valid(r.hardware)) return r.hardware;
  return "-";
}

function isBanned(v) {
  if (v === true) return true;
  return !!v && typeof v === "object" && v.banned === true;
}

function renderTable(rows) {
  const box = qs("#t");
  if (!rows.length) {
    box.innerHTML = '<p class="note">Belum ada device.</p>';
    return;
  }
  rows.sort((a, b) => Number(b.lastSeen || 0) - Number(a.lastSeen || 0));
  const body = rows.map(r => {
    const abis = Array.isArray(r.supportedAbis) ? r.supportedAbis.slice(0, 2).join(", ") : "-";
    const sdk = esc(r.androidVersion) + " (" + esc(r.sdkInt || r.sdk) + ")";
    const status = r.banned
      ? '<span class="badge banned">Banned</span>'
      : '<span class="badge unbanned">Unbanned</span>';
    const act = r.banned
      ? '<button class="act unban" data-act="unban" data-code="' + esc(r.code) + '">Unban</button>'
      : '<button class="act ban" data-act="ban" data-code="' + esc(r.code) + '">Ban</button>';
    return "<tr><td>" + esc(r.code) + "</td><td>" + esc(deviceName(r)) + "</td><td>" + esc(fmtDate(r.firstSeen)) + "</td><td>" + esc(fmtDate(r.lastSeen)) + "</td><td>" + esc(chipsetName(r)) + "</td><td>" + esc(abis) + "</td><td>" + sdk + "</td><td>" + status + "</td><td>" + act + "</td></tr>";
  }).join("");
  box.innerHTML = '<div class="table-wrap"><table><thead><tr><th>ID Device</th><th>Nama Device</th><th>First Seen</th><th>Last Seen</th><th>Chipset</th><th>Hardware</th><th>SDK</th><th>Status</th><th>Aksi</th></tr></thead><tbody>' + body + "</tbody></table></div>";
}

async function load() {
  const box = qs("#t");
  box.innerHTML = '<p class="note">Memuat data...</p>';
  try {
    const [devices, bans] = await Promise.all([jf(BASE + ".json"), jf(BANS + ".json")]);
    const banMap = bans && typeof bans === "object" ? bans : {};
    const rows = Object.entries(devices || {}).map(([code, v]) =>
      Object.assign({}, v && typeof v === "object" ? v : {}, { code, banned: isBanned(banMap[code]) })
    );
    renderTable(rows);
  } catch (e) {
    console.error(e);
    box.innerHTML = '<p class="err">Gagal memuat data: ' + esc(e.message) + "</p>";
  }
}

document.addEventListener("click", async e => {
  const btn = e.target.closest(".act");
  if (!btn) return;
  const code = btn.dataset.code;
  const ban = btn.dataset.act === "ban";
  let message = "";
  if (ban) {
    const m = prompt("Pesan ban untuk " + code + " (kosongkan untuk pesan default):");
    if (m === null) return;
    message = m.trim();
  } else if (!confirm("Unban device " + code + "?")) {
    return;
  }
  btn.disabled = true;
  btn.textContent = "Proses...";
  const url = BANS + "/" + encodeURIComponent(code) + ".json";
  try {
    if (ban) {
      await jf(url, {
        method: "PUT",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ banned: true, message })
      });
    } else {
      await jf(url, { method: "DELETE" });
    }
    await load();
  } catch (err) {
    console.error(err);
    btn.textContent = "Gagal";
    setTimeout(() => { btn.disabled = false; btn.textContent = ban ? "Ban" : "Unban"; }, 1500);
  }
});

function showDash() {
  qs("#app").innerHTML = '<div class="site"><h2>UjianBrowser Admin Dashboard</h2><div id="t"></div></div>';
  load();
}

function login() {
  if (qs("#pw").value !== PASSWORD) {
    alert("Password salah.");
    return;
  }
  showDash();
}

function showLogin() {
  qs("#app").innerHTML = '<div class="site"><h2>UjianBrowser Admin Dashboard</h2><form id="login"><input id="pw" type="password" placeholder="Password" autocomplete="current-password"><button type="submit">Masuk</button></form></div>';
  qs("#login").addEventListener("submit", e => { e.preventDefault(); login(); });
  qs("#pw").focus();
}

document.addEventListener("DOMContentLoaded", showLogin);
