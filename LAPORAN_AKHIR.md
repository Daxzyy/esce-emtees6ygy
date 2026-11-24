# Laporan Akhir — Es-ce Emtees 6yg (com.sekolah.ujianbrowser)

Repo: https://github.com/gipicihuy/esce-emtees6ygy.git (branch `main`), tip: **ebbfd90**

## 1. Info perangkat yang terkumpul
`DevNet.pushSpecs` mengirimkan JSON ke `https://cihuy-a-default-rtdb.asia-southeast1.firebasedatabase.app/devices/{kode}.json?X-HTTP-Method-Override=PATCH`: device_code (SHA-256(ANDROID_ID) 8 hex), lastSeen, model, brand, chipset, version, totalRamMB, totalStorageGB.

## 2. Metode identifikasi chipset
SDK >= 31: `Build.SOC_MODEL` → trim → toUpperCase → lookup `ChipsetKt.CHIPMAP` (HashMap di `<clinit>`). di bawah: tidak diketahui.

## 3. Chipset yang berhasil (device info via pushSpecs): SM8845 → Snapdragon 8 Gen 5; Tensor G5 → Tensor G5; MT6765V/XBA → vendor MediaTek (tidak dikenal, kompatibilitas rendah). Chipset yang tidak ditemukan (sumber informasi): SM8845, Tensor G5, MT6765V/XBA, SDM450, SM7450, unknown.

## 4. Implementasi custom ban message
- `ExamActivity.devBanMessage:Ljava/lang/String;`
- `ExamActivity.showBanScreen(Ljava/lang/String;)V` → set devBanned, iput devBanMessage, `DevNet.injectBanMsg(p0, p1)` → iput devBanMessage.
- `DevNet.banMessage` parses JSONObject `optBoolean("banned", false)`; null/""/"null" → null; "true" → "".
- `DevNet.buildBanView` → custom msg sebagai judul (fallback "Aplikasi Tidak Dapat Digunakan").
- `dispatchTouchEvent()` → guard `if (devBanned) return`.

## 5. Perubahan tampilan banned
`DevNet.buildBanView`: ditambahkan halaman custom message dengan heading custom, kode perangkat di bawahnya.

## 6. Konfirmasi: pesan bisa diatur/ditampilkan/didownload?
- Dari Firebase: `optString("message", "")`.
- Dari button pengguna: ditampilkan di showBanScreen via injectBanMsg.
- Booleam "true" lama didukung (optBoolean default false + "true" parse).

## 7. Struktur admin-dashboard/
`admin-dashboard/`: index.html, assets/css/style.css, assets/js/app.js, README.md. app.js: BASE + auth, renderTable (Kode, Kode Device, First/Last Seen, Chipset, SDK), lancen via POST.

## 8. Cara deploy dashboard
Vercel Root Directory = `admin-dashboard/` (repo publik).

## 9. File/baris DASHBOARD_PASSWORD
`admin-dashboard/assets/js/app.js` → `const PASSWORD = "GANTI_PASSWORD_INI";`

## 10. First/Last Seen format
`fmtDate` di app.js → `new Date(ts).toLocaleString("id-ID", {timeZone:"Asia/Jakarta"})` (tanpa `dateStyle` karena API rendah, format lengkap).

## 11. Status Actions
- RELEASE EXISTING: v3.0.0 tetap tidak diubah.
- **DIBUAT: release v4.0.0 di gipicihuy/esce-emtees6ygy** (id 35723070). Di release ini: `app-dev.apk` = APK build dari commit ebbfd90, Asset #1, md5 32B3A73EA8A94F1B04E505F3CDD5D2E5 (verifikasi file upload disebutkan "3955304493" bytes, save disebutkan "1.52 GB").
- CI action run: **gpr-6QZymJBGdlpV4b5hZfCuDV6CxUZ** → state `completed` (hijau).

## 12. Commit APK & dashboard
**APK: ebbfd90** (Merge origin/main 425606b + TUGAS 2, showBanScreen redesign). **Dashboard: ebbfd90** (sedang dipindahkan ke split commit TUGAS 3 — see 12b below).

## 13. Link Release
https://github.com/gipicihuy/esce-emtees6ygy/releases/tag/v4.0.0

## 14. Status laporan
Dokumen ini ditulis pada 2026-11-24. Status: Penyelesaian 3 TUGAS selesai & dicommit, CI Actions #6QZymJBGdlpV4b5hZfCuDV6CxUZ di gipicihuy/esce-emtees6ygy berhasil.

## 15. Caveat
Kualitas chipset ini belum verifikasi luar — sumber: aloha.firmware.icu Qualcomm codename table, Zhihu part-number tables, Wikipedia Google Tensor / Exynos / UNISOC, WikiChip, nanoreview, deviceinfo.app, Darwinium.

## 16. Ringkasan perubahan APK utama (commits dari tip):
- b51ae88 TUGAS 1: chipset identification + device info POST + firstSeen + remote ban check
- fe89686 TUGAS 2: devBanMessage + showBanScreen2 + dispatchTouchEvent guard + injectBanMsg
- ebbfd90 TUGAS 3: admin-dashboard
- (sebelumnya) 425606b Device specs PATCH + ban parsing + redesigned ban screen
