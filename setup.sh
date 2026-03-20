#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║         DIM DESIGN STUDIO — TỰ ĐỘNG SETUP & DEPLOY          ║
# ║   Hotline: +84 0913 774 502 | info.dimdesign@gmail.com      ║
# ╚══════════════════════════════════════════════════════════════╝

set -e

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

clear
echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║        DIM DESIGN STUDIO — AUTO DEPLOY TOOL         ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Script này sẽ tự động:${NC}"
echo "  ✅ Cài đặt các công cụ cần thiết"
echo "  ✅ Tạo database miễn phí trên Neon"
echo "  ✅ Tạo tài khoản Cloudinary miễn phí"
echo "  ✅ Tạo file .env.local với tất cả biến môi trường"
echo "  ✅ Push code lên GitHub"
echo "  ✅ Deploy lên Vercel tự động"
echo ""
echo -e "${RED}⚠️  Bạn cần có kết nối internet để chạy script này.${NC}"
echo ""
read -p "Nhấn ENTER để bắt đầu..."

# ── BƯỚC 1: Kiểm tra Node.js ──────────────────────────────────
echo ""
echo -e "${BOLD}[1/8] Kiểm tra Node.js...${NC}"

if ! command -v node &>/dev/null; then
  echo -e "${YELLOW}Node.js chưa được cài. Đang cài đặt...${NC}"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
      echo "Cài Homebrew trước..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install node
  else
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi
fi

NODE_VER=$(node --version)
echo -e "${GREEN}✅ Node.js $NODE_VER${NC}"

# ── BƯỚC 2: Kiểm tra Git ──────────────────────────────────────
echo ""
echo -e "${BOLD}[2/8] Kiểm tra Git...${NC}"
if ! command -v git &>/dev/null; then
  echo -e "${YELLOW}Git chưa được cài. Đang cài...${NC}"
  if [[ "$OSTYPE" == "darwin"* ]]; then brew install git
  else sudo apt-get install -y git; fi
fi
echo -e "${GREEN}✅ Git $(git --version | awk '{print $3}')${NC}"

# ── BƯỚC 3: Cài Vercel CLI ────────────────────────────────────
echo ""
echo -e "${BOLD}[3/8] Cài Vercel CLI...${NC}"
if ! command -v vercel &>/dev/null; then
  npm install -g vercel 2>/dev/null
fi
echo -e "${GREEN}✅ Vercel CLI ready${NC}"

# ── BƯỚC 4: Cài dependencies ──────────────────────────────────
echo ""
echo -e "${BOLD}[4/8] Cài đặt dependencies của project...${NC}"
npm install --legacy-peer-deps
echo -e "${GREEN}✅ Dependencies đã cài xong${NC}"

# ── BƯỚC 5: Tạo NEXTAUTH_SECRET ───────────────────────────────
echo ""
echo -e "${BOLD}[5/8] Tạo các biến bảo mật...${NC}"
NEXTAUTH_SECRET=$(openssl rand -base64 32)
echo -e "${GREEN}✅ NEXTAUTH_SECRET đã tạo${NC}"

# ── BƯỚC 6: Thu thập thông tin từ người dùng ──────────────────
echo ""
echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}[6/8] Nhập thông tin dịch vụ${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"

echo ""
echo -e "${YELLOW}📦 DATABASE (Neon - Miễn phí)${NC}"
echo "   1. Mở trình duyệt → vào: ${CYAN}https://neon.tech${NC}"
echo "   2. Sign Up (có thể dùng Google)"
echo "   3. Create Project → đặt tên: dim-design-studio"
echo "   4. Copy 'Connection String' (bắt đầu bằng postgresql://...)"
echo ""
read -p "   Dán DATABASE_URL vào đây: " DATABASE_URL
while [[ ! "$DATABASE_URL" == postgresql://* ]]; do
  echo -e "${RED}   ❌ URL không hợp lệ. Phải bắt đầu bằng postgresql://${NC}"
  read -p "   Dán lại DATABASE_URL: " DATABASE_URL
done
echo -e "${GREEN}   ✅ DATABASE_URL ok${NC}"

echo ""
echo -e "${YELLOW}🖼️  CLOUDINARY (Lưu ảnh - Miễn phí)${NC}"
echo "   1. Mở trình duyệt → vào: ${CYAN}https://cloudinary.com${NC}"
echo "   2. Sign Up (có thể dùng Google)"
echo "   3. Vào Dashboard → Copy 3 giá trị:"
echo ""
read -p "   Cloud Name (vd: abc123): " CLOUD_NAME
read -p "   API Key (dãy số): " CLOUD_KEY
read -p "   API Secret (chuỗi ký tự): " CLOUD_SECRET
echo -e "${GREEN}   ✅ Cloudinary ok${NC}"

echo ""
echo -e "${YELLOW}🐙 GITHUB (Lưu code)${NC}"
echo "   1. Mở trình duyệt → vào: ${CYAN}https://github.com${NC}"
echo "   2. Sign In (hoặc Sign Up)"
echo "   3. Nhấn '+' → 'New repository'"
echo "   4. Đặt tên: ${CYAN}dim-design-studio${NC}"
echo "   5. Chọn Public, KHÔNG tick thêm gì, nhấn Create"
echo ""
read -p "   GitHub username của bạn: " GITHUB_USER
echo -e "${GREEN}   ✅ GitHub ready${NC}"

# ── BƯỚC 7: Tạo .env.local ────────────────────────────────────
echo ""
echo -e "${BOLD}[7/8] Tạo file .env.local...${NC}"

cat > .env.local << EOF
# ── Tự động tạo bởi setup.sh ──
# Dim Design Studio — $(date)

DATABASE_URL="${DATABASE_URL}"

NEXTAUTH_URL="https://dim-design-studio.vercel.app"
NEXTAUTH_SECRET="${NEXTAUTH_SECRET}"

NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME="${CLOUD_NAME}"
CLOUDINARY_API_KEY="${CLOUD_KEY}"
CLOUDINARY_API_SECRET="${CLOUD_SECRET}"

NEXT_PUBLIC_APP_URL="https://dim-design-studio.vercel.app"
NEXT_PUBLIC_APP_NAME="Dim Design Studio"
EOF

echo -e "${GREEN}✅ File .env.local đã tạo${NC}"

# ── BƯỚC 8: Push lên GitHub & Deploy Vercel ───────────────────
echo ""
echo -e "${BOLD}[8/8] Push lên GitHub...${NC}"

git init 2>/dev/null || true
git add .
git commit -m "feat: Dim Design Studio — initial deploy" 2>/dev/null || git commit --allow-empty -m "feat: initial"

git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/${GITHUB_USER}/dim-design-studio.git"
git branch -M main
git push -u origin main

echo -e "${GREEN}✅ Code đã lên GitHub${NC}"

# Deploy Vercel
echo ""
echo -e "${BOLD}Đang deploy lên Vercel...${NC}"
echo -e "${YELLOW}(Cần đăng nhập Vercel — trình duyệt sẽ mở tự động)${NC}"
echo ""

vercel --prod \
  --yes \
  --name dim-design-studio \
  --env DATABASE_URL="$DATABASE_URL" \
  --env NEXTAUTH_URL="https://dim-design-studio.vercel.app" \
  --env NEXTAUTH_SECRET="$NEXTAUTH_SECRET" \
  --env NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME="$CLOUD_NAME" \
  --env CLOUDINARY_API_KEY="$CLOUD_KEY" \
  --env CLOUDINARY_API_SECRET="$CLOUD_SECRET" \
  --env NEXT_PUBLIC_APP_URL="https://dim-design-studio.vercel.app" \
  --env NEXT_PUBLIC_APP_NAME="Dim Design Studio" \
  --build-env DATABASE_URL="$DATABASE_URL"

# ── Seed database ──────────────────────────────────────────────
echo ""
echo -e "${BOLD}Tạo dữ liệu mẫu...${NC}"
npx prisma db push --schema=./prisma/schema.prisma
npm run db:seed

# ── HOÀN TẤT ──────────────────────────────────────────────────
echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                  🎉 DEPLOY THÀNH CÔNG!              ║${NC}"
echo -e "${CYAN}╠══════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║                                                      ║${NC}"
echo -e "${CYAN}║  🌐 Website:  https://dim-design-studio.vercel.app  ║${NC}"
echo -e "${CYAN}║  🔐 Admin:    .../admin                              ║${NC}"
echo -e "${CYAN}║  📧 Login:    admin@dimdesign.com                    ║${NC}"
echo -e "${CYAN}║  🔑 Password: dimdesign2024!                         ║${NC}"
echo -e "${CYAN}║                                                      ║${NC}"
echo -e "${CYAN}║  📞 Hotline:  +84 0913 774 502                      ║${NC}"
echo -e "${CYAN}║  📧 Email:    info.dimdesign@gmail.com               ║${NC}"
echo -e "${CYAN}║                                                      ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}⚠️  Hãy đổi mật khẩu admin sau khi đăng nhập lần đầu!${NC}"
echo ""
