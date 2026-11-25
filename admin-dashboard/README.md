# Admin Dashboard - UjianBrowser
Dashboard statis untuk memantau dan mem-ban device ujian lewat Firebase RTDB.

## Deploy
Vercel, Root Directory = `admin-dashboard/` (repo publik). Tanpa build step.

## Fitur
- Header + ringkasan: Total device, Online, Banned
- Search (nama, ID, chipset) dan filter Semua / Online / Offline / Banned
- Daftar device berbentuk card responsif (tanpa scroll horizontal, di HP bertumpuk)
  - Nama Device = nama resmi GSM Arena, model tampil di bawahnya (contoh `Infinix Note 40` / `X6853`); kalau tidak dikenali fallback ke manufacturer + model (contoh `Oppo CPH2269`), ID Device = kode device
  - Gambar HP resmi GSM Arena tampil di kiri nama, ukuran tetap dan tidak terdistorsi
  - Chipset, RAM / Storage, Android (SDK), First seen
- Status ala WhatsApp: badge **Online** (hijau) kalau `lastSeen` <= 10 detik yang lalu,
  kalau tidak tampil "Terakhir dilihat ..."
- Auto-refresh data tiap 4 detik tanpa reload. Scroll, search, dan filter tidak reset
  (kartu di-update per device, bukan dirender ulang)
- Tombol filter (Semua/Online/Offline/Banned) menampilkan jumlah device per kategori.
- Riwayat pesan ban custom per device: tombol jam di kartu. Tiap ban/edit dengan pesan terisi dicatat
  ke `/ban_history/{kode}/{pushId}` = `{message, at, type}` (type: `ban` atau `edit`).
  Tampilan modal = linimasa vertikal (titik + garis), terbaru di atas, pesan dipotong 2 baris dengan
  tombol "Selengkapnya" (muncul cuma kalau memang kepotong). Pesan yang sedang aktif ditandai
  "Aktif sekarang" (digabung dengan entri terbaru kalau pesannya sama, tidak dobel).
- Ban pakai modal (input pesan opsional), Unban pakai modal konfirmasi.
  Ban menulis `/banned/{kode}` = `{banned: true, message}`, Unban menghapus node itu
- Tema light/dark (ikut sistem, bisa diganti lewat tombol di header, tersimpan)
- Login: ada tombol lihat/sembunyikan password. Setelah password benar, sesi tersimpan di
  `localStorage` dan berlaku **1 hari**, lewat itu otomatis diminta login lagi.
  Tombol **Logout** menghapus sesi lebih awal

## Format tanggal
Zona Asia/Jakarta, tanpa garis miring: `Hari ini 14.32`, `Kemarin 09.10`,
`22 Nov 2026, 14.32`. Berlaku untuk Last seen dan First seen.

## Data device (`/devices/{kode}`)
`model`, `manufacturer`, `chipset`, `socModel`, `hardware`, `supportedAbis`,
`androidVersion`, `sdkInt`, `totalRamMB`, `totalStorageGB`, `firstSeen`, `lastSeen`.
Field `deviceName` (nama bikinan user dari pengaturan HP) sudah tidak dikirim lagi oleh app
dan tidak dipakai dashboard.

`gsmaName`, `gsmaImage`, `gsmaUrl`, `gsmaModels`, dan `gsmaResolvedAt` ditulis otomatis oleh resolver GSM Arena kalau kode modelnya cocok. Kalau tidak ketemu, field `gsmaMissing` + `gsmaCheckedAt` dipakai supaya tidak scraping ulang selama 7 hari. Index tetap ada di `data/gsma-index.json`, dan workflow `.github/workflows/gsma-resolve.yml` menjalankan backfill tiap 10 menit untuk device lama maupun baru.

`gsmaImage` boleh diedit manual di Firebase; dashboard memakainya dalam ≤4 detik dan workflow tidak akan menimpa selama `gsmaName` + `gsmaImage` masih terisi. Untuk memaksa resolve ulang, hapus `gsmaName`, `gsmaImage`, `gsmaCheckedAt`, dan `gsmaMissing` pada device itu.

Kalau field tersebut belum sempat ditulis workflow, dashboard memakai `data/gsma-index.json` sebagai fallback (di-load sekali per sesi, tanpa menulis balik ke Firebase). Data manual di Firebase tetap diprioritaskan.

`lastSeen` ditulis app memakai server timestamp Firebase (`{".sv":"timestamp"}`), jadi tidak
terpengaruh jam HP yang salah. Dashboard membandingkannya dengan jam server kalau header
`Date` Firebase terbaca, kalau tidak pakai jam browser.

## Catatan
- Password di `assets/js/app.js` (`PASSWORD`). Ini client-side: bisa dilihat via DevTools. GANTI.
  Kalau password diganti, login yang tersimpan otomatis tidak berlaku lagi.

- Tema terang memakai konsep Warm Neutral / Soft Minimalist (cream, ivory, muted brown, earth tone). Semua warna lewat token CSS di `assets/css/style.css`; tema gelap tidak berubah.
- Mode grid memakai kartu "hero baterai": persen baterai di atas latar air bergelombang (level = persen, warna ikut status), aksi hanya riwayat + ban/unban, tombol salin menempel di kanan ID.
