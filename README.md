# Dim Design Studio — Production Website

A premium, production-ready Next.js 14 website for **Dim Design**, a luxury architecture & interior design studio.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Next.js 14 (App Router) |
| Language | TypeScript |
| Styling | TailwindCSS + custom design tokens |
| Animation | Framer Motion |
| Database | PostgreSQL via Prisma ORM |
| Auth | NextAuth.js (credentials) |
| Media | Cloudinary |
| Deployment | Vercel |
| UI | Glassmorphism + Luxury Minimalism |

---

## Project Structure

```
dim-design/
├── app/
│   ├── layout.tsx              # Root layout (fonts, providers, header/footer)
│   ├── page.tsx                # Home page
│   ├── globals.css             # Global styles + design tokens
│   ├── about/page.tsx          # About page
│   ├── projects/
│   │   ├── page.tsx            # Projects listing with filter
│   │   ├── ProjectsGrid.tsx    # Client grid with category filter
│   │   └── [slug]/
│   │       ├── page.tsx        # Project detail + metadata
│   │       └── ProjectGallery.tsx  # Lightbox gallery
│   ├── blog/
│   │   ├── page.tsx            # Blog listing
│   │   └── [slug]/page.tsx     # Blog detail
│   ├── team/
│   │   ├── page.tsx            # Team page
│   │   └── TeamGrid.tsx        # Team cards with modal
│   ├── contact/
│   │   ├── page.tsx            # Contact page
│   │   └── ContactForm.tsx     # React Hook Form + Zod
│   ├── admin/
│   │   ├── layout.tsx          # Protected admin layout
│   │   ├── page.tsx            # Dashboard overview
│   │   ├── AdminSidebar.tsx    # Sidebar navigation
│   │   ├── login/page.tsx      # Login page
│   │   ├── projects/           # Projects CRUD
│   │   ├── blog/               # Blog CRUD (extend pattern)
│   │   ├── team/               # Team CRUD (extend pattern)
│   │   └── messages/page.tsx   # Contact messages
│   └── api/
│       ├── auth/[...nextauth]/ # NextAuth handler
│       ├── projects/           # Projects REST API
│       ├── contact/            # Contact form + messages
│       └── upload/             # Cloudinary upload
├── components/
│   ├── Providers.tsx           # SessionProvider wrapper
│   ├── layout/
│   │   ├── Header.tsx          # Sticky blur header + mobile nav
│   │   └── Footer.tsx          # Full footer
│   ├── sections/
│   │   ├── HeroSection.tsx     # Fullscreen hero with parallax
│   │   ├── FeaturedProjects.tsx # Masonry project grid
│   │   └── HomeSections.tsx    # About/Services/Testimonials/CTA
│   └── ui/
│       ├── Motion.tsx          # FadeIn, StaggerChildren, Parallax
│       └── LoadingScreen.tsx   # Logo animation loading screen
├── lib/
│   ├── prisma.ts               # Prisma client singleton
│   ├── auth.ts                 # NextAuth config
│   └── utils.ts                # cn(), slugify, formatDate, etc.
├── prisma/
│   ├── schema.prisma           # Database models
│   └── seed.ts                 # Sample data
├── types/index.ts              # TypeScript types
├── tailwind.config.ts          # Extended design system
├── next.config.mjs             # Next.js config
└── tsconfig.json
```

---

## Quick Start

### 1. Clone & Install

```bash
git clone https://github.com/your-org/dim-design.git
cd dim-design
npm install
```

### 2. Environment Variables

```bash
cp .env.example .env.local
```

Fill in `.env.local`:

```env
# PostgreSQL (local or Supabase/Neon)
DATABASE_URL="postgresql://user:password@localhost:5432/dim_design"

# NextAuth — generate secret: openssl rand -base64 32
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-secret-here"

# Cloudinary — create free account at cloudinary.com
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME="your-cloud-name"
CLOUDINARY_API_KEY="your-api-key"
CLOUDINARY_API_SECRET="your-api-secret"

NEXT_PUBLIC_APP_URL="http://localhost:3000"
```

### 3. Database Setup

```bash
# Generate Prisma client
npm run db:generate

# Push schema to database
npm run db:push

# Seed with sample data (projects, team, testimonials, admin user)
npm run db:seed
```

### 4. Run Development Server

```bash
npm run dev
```

Visit:
- **Website** → http://localhost:3000
- **Admin** → http://localhost:3000/admin
  - Email: `admin@dimdesign.com`
  - Password: `dimdesign2024!`

---

## Database Options

### Local PostgreSQL
```bash
# macOS
brew install postgresql@16
brew services start postgresql@16
createdb dim_design
```

### Neon (Recommended — Free Cloud PostgreSQL)
1. Create account at [neon.tech](https://neon.tech)
2. Create project → copy connection string
3. Paste in `DATABASE_URL`

### Supabase
1. Create project at [supabase.com](https://supabase.com)
2. Settings → Database → Connection string (URI mode)

---

## Cloudinary Setup

1. Create free account at [cloudinary.com](https://cloudinary.com)
2. Dashboard → Copy Cloud Name, API Key, API Secret
3. Paste into `.env.local`

Images upload via `/api/upload` route with auto-optimization and WebP conversion.

---

## Deploying to Vercel

### Option A: Vercel CLI

```bash
npm install -g vercel
vercel login
vercel --prod
```

### Option B: GitHub Integration

1. Push project to GitHub
2. Go to [vercel.com/new](https://vercel.com/new)
3. Import your repository
4. Add environment variables in Vercel dashboard:
   - `DATABASE_URL`
   - `NEXTAUTH_SECRET`
   - `NEXTAUTH_URL` (set to your Vercel domain)
   - `NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME`
   - `CLOUDINARY_API_KEY`
   - `CLOUDINARY_API_SECRET`
5. Deploy

### Post-Deploy

```bash
# Run migrations on production DB
npx prisma db push

# Seed production data (optional)
npm run db:seed
```

---

## Key Features

### Public Website
- ✅ Fullscreen hero with parallax + animated entrance
- ✅ Masonry project grid with category filter
- ✅ Project detail with lightbox gallery
- ✅ About page with philosophy & awards
- ✅ Team page with modal profiles
- ✅ Blog/Journal with SEO metadata
- ✅ Contact form with Zod validation
- ✅ Sticky blur header + animated mobile nav
- ✅ Loading screen with logo animation
- ✅ Smooth Framer Motion page transitions
- ✅ Glassmorphism throughout
- ✅ Responsive on all screen sizes

### Admin Dashboard
- ✅ Protected with NextAuth credentials
- ✅ Dashboard overview with stats
- ✅ Projects CRUD (create, read, update, delete)
- ✅ Cloudinary image upload with preview
- ✅ Contact message inbox with read/delete
- ✅ Extend pattern for Blog and Team CRUD

### Performance & SEO
- ✅ `next/image` optimization (WebP + lazy load)
- ✅ Dynamic `generateMetadata` per page
- ✅ OpenGraph tags
- ✅ Code splitting (App Router)
- ✅ Vercel Analytics + Speed Insights

---

## Extending the Admin

The Blog and Team admin pages follow the exact same pattern as Projects. To add them:

1. Create `/app/admin/blog/page.tsx` — list posts (same as projects list)
2. Create `/app/admin/blog/BlogForm.tsx` — form with TipTap rich text
3. Create `/app/api/blog/route.ts` — GET + POST
4. Create `/app/api/blog/[id]/route.ts` — PUT + DELETE

```tsx
// Add TipTap rich text editor to BlogForm
import { useEditor, EditorContent } from '@tiptap/react'
import StarterKit from '@tiptap/starter-kit'

const editor = useEditor({
  extensions: [StarterKit],
  content: initialContent,
  onUpdate: ({ editor }) => setValue('content', editor.getHTML()),
})
```

---

## Design System

### Colors
```css
--background: #0A0A0A    /* Deep black */
--surface:    #111111    /* Card backgrounds */
--accent:     #C9A96E    /* Elegant gold */
--border:     rgba(255,255,255,0.08)
```

### Typography
- **Display**: Cormorant Garamond (serif) — headings, quotes
- **Body**: Inter — UI, body text

### Key Classes
```css
.heading-display   /* Huge display text — hero */
.heading-xl        /* Section headings */
.heading-lg        /* Sub-section headings */
.label             /* Gold uppercase labels */
.body-lg           /* Large body text */
.glass             /* Glassmorphism panel */
.glass-accent      /* Gold-tinted glass */
.btn-primary       /* Gold gradient button */
.btn-outline       /* Gold border button */
.card              /* Dark card surface */
.container-xl      /* Max-width container */
.section           /* Vertical section spacing */
```

---

## License

Built exclusively for Dim Design Studio. All rights reserved.
