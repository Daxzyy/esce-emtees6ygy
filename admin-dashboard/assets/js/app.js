const BASE="https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/devices";
const PASS="GANTI_PASSWORD_INI";
async function jf(u){const r=await fetch(u);if(!r.ok)throw new Error(r.status);return r.json()}
let ran=false;function render(d){if(ran)return;ran=true;const t=document.querySelector("#t");t.innerHTML="<tr><th>Kode</th><th>Kode Device</th><th>First/Last Seen</th><th>Aksi</th></tr>";Object.keys(d||{}).forEach(k=>{const r=document.createElement("tr");r.innerHTML='<td>'+k+'</td><td>'+ (d[k].code||d[k].device_code||"") +'</td><td>'+d[k].firstSeen+' / '+d[k].lastSeen+'</td><td><button class="lancen" disabled>Lancen</button></td>';t.append(r)})}
(async()=>{try{const p=await jf(BASE+".json");render(p)}catch(e){console.error(e)}})();
document.body.addEventListener("click",e=>{const b=e.target.closest("button");if(b&&b.textContent==="Lancen"){b.disabled=true;b.textContent="Proses..."}});
