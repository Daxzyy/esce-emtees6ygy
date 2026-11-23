# sc-6kbm

**Full source** aplikasi ujian `com.sekolah.ujianbrowser` (Ujian MTsN 6 Kebumen,
versionCode 3) + pipeline build otomatis.

Isi repo ini:

```
src/                          ← source lengkap (hasil decode apktool, sudah di-patch)
  AndroidManifest.xml         ← binary asli, tidak diubah
  resources.arsc, res/        ← resource asli, tidak diubah
  smali*/                     ← kode; ini yang boleh kamu edit
  apktool.yml
patch.py                      ← 21 patch (semua bergantung mode)
.github/workflows/release.yml ← CI: build → sign → tempel ke Releases
base/Ujian-MTsN6v3.apk        ← APK asli, cuma buat kalau mau decode versi baru
```

Karena source-nya sudah ada di repo, **tidak perlu decompile ulang** — edit
`src/smali_*/...` langsung, push, CI yang build.

## Mode Mod vs Mode Default (easter egg)

Aplikasi punya dua mode. Pindahnya **tanpa tombol, tanpa menu, tanpa indikator**:

> **Double-tap di area layar mana pun** (2 tap cepat, selisih ≤ 300 ms)
> → mode berganti. Ulangi untuk balik.

Tidak ada yang berubah di tampilan sampai mode-nya berganti, dan statusnya
disimpan di `SharedPreferences` (`ujian_dev/mod`) jadi bertahan sampai app
dibuka lagi.

| | **Mode Mod** (default, saat pertama install) | **Mode Default** (APK asli) |
|---|---|---|
| Lock task / sematkan layar | Mati | Aktif |
| Deteksi pindah aplikasi | Mati | Aktif (toast + siren + getaran) |
| Alarm & siren | Mati | Aktif |
| Volume & DND dipaksa | Tidak disentuh | Dipaksa |
| `FLAG_SECURE` (screenshot) | Diizinkan | Dilarang |
| Tombol Back | Langsung keluar | Muncul dialog konfirmasi |
| Timer ujian 60 menit | Tidak berlaku | Berjalan |
| Kode admin + lockout | Selalu benar | Kode asli, lockout aktif |
| Gerbang "Layar belum terkunci" | Tidak dibangun | Ditampilkan, WebView disembunyikan sampai layar terkunci |
| Watchdog lock-task 700 ms | Mati | Berjalan |

Saat pindah mode, semuanya ikut menyesuaikan seketika: flag window, callback
Back, gerbang/WebView, loop `lockWatch` + `armCheck`, alarm yang sedang bunyi,
dan lock task yang sedang aktif.

Bar status atas dan tombol navigasi bawah **tetap disembunyikan di kedua mode**
seperti APK asli. Untuk melihatnya, usap dari tepi layar ke dalam — bar muncul
sebentar lalu hilang sendiri (`BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE`).

> Catatan: masuk Mode Default menampilkan gerbang "Layar belum terkunci"
> (memang perilaku APK asli). Double-tap lagi untuk kembali ke Mode Mod —
> gerbang dilepas dan soal langsung kelihatan lagi.

Tidak ada kode di aplikasi ini yang mengirim laporan ke server — deteksi
"keluar aplikasi" cuma tampil di HP murid itu sendiri.

## Cara install

Ambil APK dari halaman **[Releases](../../releases)**, unduh, lalu buka file-nya.

> Build dev ini **tidak bisa ditimpa** APK asli (signature beda).
> Untuk balik ke APK asli, uninstall dulu build dev-nya.

## Cara build sendiri

```bash
java -jar apktool.jar b src -o unsigned.apk
```

Kalau mau pastikan patch-nya masih aktif:

```bash
PATCH_ROOT="$PWD/src" python3 patch.py
```

Skripnya idempoten: blok yang sudah terpasang akan cetak
`SKIP already applied: ...`, blok yang bentuknya berubah di APK baru akan
berhenti dengan pesan jelas (bukan diam-diam gagal).

## Cara rilis

```bash
git tag v4.0.0
git push origin v4.0.0
```

Workflow **Build & Release** jalan otomatis: cek patch → build → zipalign →
sign → tempel ke GitHub Release. Tinggal unduh dari halaman Releases.

Jalankan manual kapan saja lewat tab **Actions → Build & Release → Run workflow**
(bikin artifact, tanpa rilis).

## Porting ke versi APK baru

```bash
java -jar apktool.jar d -f -r APK-BARU.apk -o src
PATCH_ROOT="$PWD/src" python3 patch.py   # terapkan 21 patch ke source baru
git add -A && git commit -m "port to versionCode N"
git tag vN.0.0 && git push origin vN.0.0
```

## Secrets yang dibutuhkan CI

| Nama | Isi |
|---|---|
| `APK_KEYSTORE_B64` | `base64 -w0 keystore.jks` |
| `APK_KEYSTORE_PASS` | password keystore |
| `APK_KEY_ALIAS` | alias key |

Signature harus tetap sama di tiap build supaya update bisa menimpa install
lama. **Jangan commit file keystore ke repo.**

## Dasar hukum

`README.md` di dalam APK asli menyebutkan:

> aplikasi ini boleh di modifikasi!! bebas ingin di bypass boleh menghilangkan
> suaranya dan bisa keluar bebas dan boleh screenshot, rekam layar. pokoknya bebas gas
