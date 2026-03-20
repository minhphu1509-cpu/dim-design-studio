# 🚀 Hướng Dẫn Deploy Dim Design lên Vercel

## Thông tin liên hệ
- **Hotline:** +84 0913 774 502
- **Email:** info.dimdesign@gmail.com

---

## Bước 1 — Chuẩn bị Database (Neon - Miễn phí)

1. Vào https://neon.tech → **Sign Up** (miễn phí)
2. **Create Project** → đặt tên `dim-design`
3. Copy **Connection String** dạng:
   ```
   postgresql://user:password@host/dim_design?sslmode=require
   ```
4. Lưu lại — đây là `DATABASE_URL`

---

## Bước 2 — Chuẩn bị Cloudinary (Miễn phí)

1. Vào https://cloudinary.com → **Sign Up** (miễn phí)
2. Vào **Dashboard** → Copy:
   - Cloud Name → `NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME`
   - API Key → `CLOUDINARY_API_KEY`
   - API Secret → `CLOUDINARY_API_SECRET`

---

## Bước 3 — Tạo NextAuth Secret

Chạy lệnh này trên máy tính (terminal):
```bash
openssl rand -base64 32
```
Kết quả là `NEXTAUTH_SECRET`

---

## Bước 4 — Đưa code lên GitHub

```bash
# Trong thư mục dim-design
git init
git add .
git commit -m "feat: Dim Design Studio initial commit"

# Tạo repo mới trên github.com/new
git remote add origin https://github.com/YOUR_USERNAME/dim-design-studio.git
git branch -M main
git push -u origin main
```

---

## Bước 5 — Deploy lên Vercel

### Option A: Qua website (dễ nhất)

1. Vào https://vercel.com → **Sign Up** bằng GitHub
2. Click **Add New Project**
3. Import repo `dim-design`
4. Mở **Environment Variables** → thêm từng biến:

| Key | Value |
|-----|-------|
| `DATABASE_URL` | postgresql://... (từ Neon) |
| `NEXTAUTH_URL` | https://YOUR-PROJECT.vercel.app |
| `NEXTAUTH_SECRET` | (chuỗi từ openssl) |
| `NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME` | tên cloud của bạn |
| `CLOUDINARY_API_KEY` | API key |
| `CLOUDINARY_API_SECRET` | API secret |
| `NEXT_PUBLIC_APP_URL` | https://YOUR-PROJECT.vercel.app |

5. Click **Deploy** → đợi ~2 phút

### Option B: Vercel CLI

```bash
npm install -g vercel
vercel login
vercel --prod
```

---

## Bước 6 — Seed Database (Thêm dữ liệu mẫu)

Sau khi deploy xong, chạy locally với DATABASE_URL production:

```bash
# Tạo file .env.local với DATABASE_URL từ Neon
cp .env.example .env.local
# Điền DATABASE_URL vào .env.local

# Chạy migrations
npx prisma db push

# Seed dữ liệu mẫu
npm run db:seed
```

---

## Bước 7 — Truy cập website

| URL | Mô tả |
|-----|-------|
| `https://your-app.vercel.app` | Website chính |
| `https://your-app.vercel.app/admin` | Admin dashboard |

**Đăng nhập Admin:**
- Email: `admin@dimdesign.com`
- Password: `dimdesign2024!`

> ⚠️ Đổi password sau khi đăng nhập lần đầu!

---

## Bước 8 — Domain tùy chỉnh (Tùy chọn)

1. Vercel Dashboard → Project → **Settings** → **Domains**
2. Thêm domain: `dimdesign.studio`
3. Trỏ DNS theo hướng dẫn của Vercel
4. Cập nhật `NEXTAUTH_URL` và `NEXT_PUBLIC_APP_URL` thành domain mới

---

## Cập nhật code sau này

```bash
# Mỗi lần có thay đổi
git add .
git commit -m "update: mô tả thay đổi"
git push

# Vercel tự động redeploy khi push lên main
```

---

## Troubleshooting

**Build lỗi "Prisma client not generated":**
```bash
# Vercel tự chạy: prisma generate && next build (đã config trong vercel.json)
```

**Lỗi database connection:**
- Kiểm tra `DATABASE_URL` đúng không
- Neon yêu cầu `?sslmode=require` ở cuối URL

**Lỗi NextAuth:**
- `NEXTAUTH_URL` phải khớp với URL thực tế của app
- `NEXTAUTH_SECRET` phải ≥ 32 ký tự

---

## Liên hệ hỗ trợ

📞 **+84 0913 774 502**
📧 **info.dimdesign@gmail.com**
