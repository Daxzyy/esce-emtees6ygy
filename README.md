# sc-6kbm

Build **development** dari aplikasi ujian `com.sekolah.ujianbrowser` (Ujian MTsN 6 Kebumen).

Build ini melewati penguncian kiosk / anti-cheat yang ada di APK asli.
Semua fitur lain (WebView, QR scanner, soal, pengiriman jawaban) **tidak disentuh**.

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

Tidak ada kode di aplikasi ini yang mengirim laporan ke server — deteksi "keluar
aplikasi" cuma tampil di HP murid itu sendiri.

## Cara install

Ambil APK dari halaman **[Releases](../../releases)**, unduh, lalu buka file-nya.

> Build dev ini **tidak bisa ditimpa** oleh APK asli (signature beda).
> Untuk balik ke APK asli, uninstall dulu build dev-nya.

## Cara build sendiri

Repo ini sudah berisi APK dasar + patch, jadi **tidak perlu decompile manual**.

```bash
java -jar apktool.jar d -f -r base/Ujian-MTsN6v3.apk -o work
PATCH_ROOT="$PWD/work" python3 patch.py
java -jar apktool.jar b work -o unsigned.apk
```

`patch.py` adalah satu-satunya tempat perubahan. Tiap blok `replace_method`
mencetak `OK <nama patch>`; kalau ada yang berubah bentuk di versi APK baru,
skripnya berhenti dengan pesan jelas (bukan diam-diam gagal).

### Nambah patch baru

1. Decode sekali: `java -jar apktool.jar d -f -r base/APK.apk -o work`
2. Cari smali yang mau diubah di `work/smali_*/...`
3. Tambahkan blok `replace_method(...)` / `replace_once(...)` di `patch.py`
4. Push. CI yang build.

## Rilis

```bash
git tag v4.0.0
git push origin v4.0.0
```

Workflow `Build & Release` jalan otomatis: decode → patch → build → sign →
tempel ke GitHub Release. Tinggal unduh dari halaman Releases.

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
