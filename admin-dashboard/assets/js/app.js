const BASE = "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/devices";
const PASSWORD = "GANTI_PASSWORD_INI";
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
    return "<tr><td>" + esc(r.code) + "</td><td>" + esc(r.device_code || r.code) + "</td><td>" + esc(fmtDate(r.firstSeen)) + "</td><td>" + esc(fmtDate(r.lastSeen)) + "</td><td>" + esc(r.chipset) + "</td><td>" + esc(abis) + "</td><td>" + sdk + '</td><td><button class="lancen" data-code="' + esc(r.code) + '">Lancen</button></td></tr>';
  }).join("");
  box.innerHTML = '<div class="table-wrap"><table><thead><tr><th>Kode</th><th>Kode Device</th><th>First Seen</th><th>Last Seen</th><th>Chipset</th><th>Hardware</th><th>SDK</th><th>Aksi</th></tr></thead><tbody>' + body + "</tbody></table></div>";
}

async function load() {
  const box = qs("#t");
  box.innerHTML = '<p class="note">Memuat data...</p>';
  try {
    const data = await jf(BASE + ".json");
    const rows = Object.entries(data || {}).map(([code, v]) => Object.assign({}, v && typeof v === "object" ? v : {}, { code }));
    renderTable(rows);
  } catch (e) {
    console.error(e);
    box.innerHTML = '<p class="err">Gagal memuat data: ' + esc(e.message) + "</p>";
  }
}

document.addEventListener("click", async e => {
  const btn = e.target.closest(".lancen");
  if (!btn) return;
  btn.disabled = true;
  btn.textContent = "Proses...";
  try {
    await jf(BASE + "/" + encodeURIComponent(btn.dataset.code) + ".json", {
      method: "POST",
      headers: { "Content-Type": "application/json; charset=utf-8" },
      body: "{}"
    });
    btn.textContent = "Terkirim";
  } catch (err) {
    console.error(err);
    btn.textContent = "Gagal";
  }
  setTimeout(() => { btn.disabled = false; btn.textContent = "Lancen"; }, 1500);
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
