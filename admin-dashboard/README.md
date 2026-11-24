# Admin Dashboard - UjianBrowser
Static dashboard untuk melihat device via Firebase RTDB.

## Deploy
Vercel, Root Directory = `admin-dashboard/` (repo publik).

## Fitur
- List devices (ID Device, Nama Device, First/Last Seen, Chipset, SDK, Status)
- Tombol Ban / Unban per device (tulis ke `/banned/{kode}` di Firebase RTDB)

## Catatan
- Password di `app.js` (`PASSWORD`). Ini client-side: bisa dilihat via DevTools. GANTI.
