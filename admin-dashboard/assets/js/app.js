const BASE = "https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/devices";
const PASSWORD = "GANTI_PASSWORD_INI";
const AUTH_HEADER = "Basic YWRtaW46YWRtaW4=";

function qs(sel) { return document.querySelector(sel); }

function fmtDate(ts) {
  if (!ts) return "-";
  try {
    const d = new Date(Number(ts));
    return isNaN(d) ? "-" : d.toLocaleString("id-ID", { timeZone: "Asia/Jakarta" });
  } catch (e) { return ts; }
}

async function jf(u, opts) {
  const r = await fetch(u, { headers: { "Authorization": AUTH_HEADER, ...(opts||{}).headers || {} }, ...opts });
  if (!r.ok) throw new Error("HTTP " + r.status);
  return r.json();
}

function renderTable(rows) {
  const t = qs("#t");
  t.innerHTML = `<thead><tr><th>Kode</th><th>Kode Device</th><th>First Seen</th><th>Last Seen</th><th>Chipset</th><th>Hardware</th><th>SDK</th><th>Aksi</th></tr></thead><tbody id="tbody"></tbody>`;
  const body = qs("#tbody");
  rows.forEach(r => {
    const tr = document.createElement("tr");
    const cd = r.code || r.device_code || "-";
    tr.innerHTML = `<td>${r.code}</td><td>${cd}</td><td>${fmtDate(r.firstSeen)}</td><td>${fmtDate(r.lastSeen)}</td><td>${r.chipset||"-"}</td><td>${(r.supportedAbis||["-"]).slice(0,2).join(", ")}</td><td>${r.androidVersion} (${r.sdkInt||r.sdk})</td><td><button class="lancen" onclick="lancen('${r.code}')">Lancen</button></td>`;
    body.append(tr);
  });
}

async function load() { renderTable(Object.keys(await jf(BASE + ".json"))); }

window.lancen = async (code) => {
  const btn = qs("#tbody .lancen[data-code='"+code+"']");
  if (btn) { btn.disabled = true; btn.textContent = "Proses..."; }
  try { await jf(BASE + "/" + code + ".json", { method: "POST", headers: {"Content-Type":"application/json; charset=utf-8"}, body: "{}", }); }
  catch (e) { console.error(e); }
};

document.addEventListener("DOMContentLoaded", async () => {
  if (qs("#pw") && qs("#app")) {
    qs("#pw").addEventListener("keydown", e => { if (e.key === "Enter") login(); });
    qs("#app").addEventListener("submit", e => { e.preventDefault(); login(); });
    qs("#app").innerHTML = `<div class="site"><h2>UjianBrowser Admin Dashboard</h2><form id="login"><input id="pw" type="password" placeholder="Password"></form><div id="t"></div></div>`;
  }
  try { await load(); } catch (e) { console.error(e); }
});

function login() {
  const pw = qs("#pw") ? qs("#pw").value : "";
  if (pw !== PASSWORD) { alert("Password salah."); return; }
  qs("#app").innerHTML = `<div class="site"><h2>UjianBrowser Admin Dashboard</h2><div id="t"></div></div>`;
  load();
}
