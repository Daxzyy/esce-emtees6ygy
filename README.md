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
patch.py                      ← daftar patch anti-cheat (15 blok)
.github/workflows/release.yml ← CI: build → sign → tempel ke Releases
base/Ujian-MTsN6v3.apk        ← APK asli, cuma buat kalau mau decode versi baru
```

Karena source-nya sudah ada di repo, **tidak perlu decompile ulang** — edit
`src/smali_*/...` langsung, push, CI yang build.

## Yang dimatikan

| # | Fitur di APK asli | Di build ini |
|---|---|---|
| 1 | Lock task (layar terkunci di aplikasi) | Mati |
| 2 | Deteksi pindah/keluar aplikasi (toast + siren + getaran) | Mati |
| 3 | Alarm & siren | Mati |
| 4 | Getaran dipaksa | Mati |
| 5 | Volume & mode DND dipaksa | Normal |
| 6 | `FLAG_SECURE` (screenshot/rekam layar dilarang) | Diizinkan |
| 7 | Tombol Back dikunci 60 menit | Tombol Back biasa (keluar) |
| 8 | Timer ujian 60 menit | Tidak berlaku |
| 9 | Status bar & navigation bar disembunyikan | Tampil |
| 10 | Kode admin `97683106` + lockout 5 kali salah | Selalu benar, tanpa lockout |
| 11 | Gerbang overlay yang menutupi soal (v3) | Tidak dibangun |
| 12 | Watchdog lock-task 700 ms (v3) | Mati |

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
PATCH_ROOT="$PWD/src" python3 patch.py   # terapkan 15 patch ke source baru
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
