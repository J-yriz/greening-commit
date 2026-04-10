# Greening Commit

Auto-commit bot berbasis GitHub Actions untuk membuat **5 commit per hari** di branch `main`.

## Fitur

- Menjalankan update otomatis ke `update.md`
- Membuat commit dengan pesan acak + timestamp UTC
- Jadwal harian 5x: `00:00`, `05:00`, `10:00`, `15:00`, `20:00` (UTC)
- Konfigurasi git di `task.sh` memakai `--local` agar tidak mengganggu repo lain

## Struktur

- `.github/workflows/bot.yml` — workflow auto-commit
- `task.sh` — script update dan commit
- `update.md` — file yang diperbarui tiap run

## Cara Kerja Singkat

1. Workflow dipicu oleh `schedule` atau `workflow_dispatch`
2. Runner checkout branch `main`
3. Script `task.sh` menulis timestamp baru ke `update.md`
4. Runner commit perubahan
5. Runner pull `--rebase` lalu push ke `main`

## Setup Lokal (Opsional)

```bash
git clone https://github.com/J-yriz/greening-commit.git
cd greening-commit
bash task.sh
```

## Rekomendasi Proteksi Branch `main`

Tujuan: `main` tetap aman, tapi bot tetap bisa push.

### Opsi Aman untuk Workflow Bot (direkomendasikan)

Di GitHub: **Settings → Branches → Add branch protection rule** untuk `main`.

Aktifkan:

- ✅ **Require linear history**
- ✅ **Do not allow force pushes**
- ✅ **Do not allow deletions**

Jangan aktifkan dulu (untuk skenario bot push langsung ke `main`):

- ❌ **Require a pull request before merging**
- ❌ **Require status checks to pass before merging**

Dengan aturan ini, bot tetap dapat push langsung, tapi risiko overwrite histori/force push tetap dicegah.

### Jika ingin wajib PR juga

Kalau kamu ingin `Require a pull request` aktif, ubah arsitektur bot jadi:

- bot commit ke branch khusus (mis. `bot/update`)
- bot membuka PR otomatis ke `main`

## Catatan Keamanan

- `git config --local` hanya berlaku untuk repo ini
- Tidak mempengaruhi identitas commit repo lain di mesin kamu
- Hindari `git config --global` di script automation

## Troubleshooting

- Workflow tidak jalan: cek tab **Actions** dan pastikan repository actions diizinkan
- Push ditolak: cek apakah aturan branch protection terlalu ketat untuk alur bot saat ini
- Commit tidak dibuat: pastikan ada perubahan pada `update.md`
