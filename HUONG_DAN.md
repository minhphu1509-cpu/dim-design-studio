# 📖 HƯỚNG DẪN DEPLOY ĐƠN GIẢN
## Dim Design Studio

---

## Bạn cần làm GÌ?

Chỉ **1 việc duy nhất**: Chạy file script — script sẽ tự làm tất cả.

---

## BƯỚC 1 — Giải nén file ZIP

Giải nén file `dim-design-studio-final.zip` ra Desktop.

---

## BƯỚC 2 — Chạy script theo hệ điều hành

### 🍎 Nếu dùng Mac:
1. Mở **Terminal** (tìm trong Spotlight: nhấn `Cmd + Space` → gõ `Terminal`)
2. Gõ lệnh sau rồi nhấn Enter:
```
cd ~/Desktop/dim-design-studio
chmod +x setup.sh
./setup.sh
```

### 🪟 Nếu dùng Windows:
1. Vào thư mục `dim-design-studio` vừa giải nén
2. **Click phải** vào file `setup.bat`
3. Chọn **"Run as administrator"**

---

## BƯỚC 3 — Script sẽ hỏi bạn 3 thứ

Script tự động tất cả, chỉ cần bạn cung cấp:

### 📦 DATABASE_URL (từ Neon.tech — Miễn phí)
1. Mở trình duyệt → vào **https://neon.tech**
2. Đăng ký bằng Google (30 giây)
3. Nhấn **Create Project** → đặt tên `dim-design-studio`
4. Copy dòng **"Connection String"** → dán vào script

Trông như thế này:
```
postgresql://user:password@ep-xxx.us-east-1.aws.neon.tech/neondb?sslmode=require
```

---

### 🖼️ CLOUDINARY (Lưu ảnh — Miễn phí)
1. Mở trình duyệt → vào **https://cloudinary.com**
2. Đăng ký bằng Google
3. Vào **Dashboard** → copy 3 giá trị:
   - **Cloud Name** (vd: `abc123xyz`)
   - **API Key** (dãy số 15 chữ số)
   - **API Secret** (chuỗi ký tự dài)

---

### 🐙 GITHUB (Lưu code — Miễn phí)
1. Mở trình duyệt → vào **https://github.com**
2. Đăng ký (nếu chưa có)
3. Nhấn dấu **"+"** góc trên phải → **"New repository"**
4. Tên: `dim-design-studio` → nhấn **Create repository**
5. Copy **username** của bạn (tên hiển thị trên GitHub)

---

## BƯỚC 4 — Đăng nhập Vercel

Trong quá trình chạy, script sẽ mở trình duyệt để đăng nhập **Vercel**:
1. Chọn **"Continue with GitHub"**
2. Cho phép Vercel truy cập GitHub
3. Quay lại Terminal/CMD — script tiếp tục tự động

---

## KẾT QUẢ

Sau khi script chạy xong (~5 phút):

| | |
|---|---|
| 🌐 **Website** | https://dim-design-studio.vercel.app |
| 🔐 **Admin** | https://dim-design-studio.vercel.app/admin |
| 📧 **Email đăng nhập** | admin@dimdesign.com |
| 🔑 **Mật khẩu** | dimdesign2024! |

> ⚠️ **Đổi mật khẩu ngay sau khi đăng nhập lần đầu!**

---

## Liên hệ hỗ trợ

Nếu gặp lỗi, chụp màn hình và liên hệ:

📞 **+84 0913 774 502**
📧 **info.dimdesign@gmail.com**

---

*File tự động tạo bởi Dim Design Studio Setup Tool*
