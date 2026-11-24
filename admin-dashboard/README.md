# Admin Dashboard - UjianBrowser
Dashboard statis untuk memantau dan mem-ban device ujian lewat Firebase RTDB.

## Deploy
Vercel, Root Directory = `admin-dashboard/` (repo publik). Tanpa build step.

## Fitur
- Header + ringkasan: Total device, Online, Banned
- Search (nama, ID, chipset) dan filter Semua / Online / Offline / Banned
- Daftar device berbentuk card responsif (tanpa scroll horizontal, di HP bertumpuk)
  - Nama Device = manufacturer + model (contoh `OPPO CPH2269`), ID Device = kode device
  - Chipset, RAM / Storage, Android (SDK), First seen
- Status ala WhatsApp: badge **Online** (hijau) kalau `lastSeen` <= 10 detik yang lalu,
  kalau tidak tampil "Terakhir dilihat ..."
- Auto-refresh data tiap 4 detik tanpa reload. Scroll, search, dan filter tidak reset
  (kartu di-update per device, bukan dirender ulang)
- Ban pakai modal (input pesan opsional), Unban pakai modal konfirmasi.
  Ban menulis `/banned/{kode}` = `{banned: true, message}`, Unban menghapus node itu
- Tema light/dark (ikut sistem, bisa diganti lewat tombol di header, tersimpan)
- Login sekali: setelah password benar, tersimpan di `localStorage` sehingga buka lagi
  langsung masuk. Tombol **Logout** menghapusnya

## Format tanggal
Zona Asia/Jakarta, tanpa garis miring: `Hari ini 14.32`, `Kemarin 09.10`,
`22 Nov 2026, 14.32`. Berlaku untuk Last seen dan First seen.

## Data device (`/devices/{kode}`)
`model`, `manufacturer`, `chipset`, `socModel`, `hardware`, `supportedAbis`,
`androidVersion`, `sdkInt`, `totalRamMB`, `totalStorageGB`, `firstSeen`, `lastSeen`.
Field `deviceName` (nama bikinan user dari pengaturan HP) sudah tidak dikirim lagi oleh app
dan tidak dipakai dashboard.

`lastSeen` ditulis app memakai server timestamp Firebase (`{".sv":"timestamp"}`), jadi tidak
terpengaruh jam HP yang salah. Dashboard membandingkannya dengan jam server kalau header
`Date` Firebase terbaca, kalau tidak pakai jam browser.

## Catatan
- Password di `assets/js/app.js` (`PASSWORD`). Ini client-side: bisa dilihat via DevTools. GANTI.
  Kalau password diganti, login yang tersimpan otomatis tidak berlaku lagi.
