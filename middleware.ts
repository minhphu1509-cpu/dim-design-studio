import { withAuth } from 'next-auth/middleware'
import { NextResponse } from 'next/server'

export default withAuth(
  function middleware(req) {
    const { pathname } = req.nextUrl
    const token = req.nextauth.token

    // Protect all /admin routes except /admin/login
    if (pathname.startsWith('/admin') && !pathname.startsWith('/admin/login')) {
      if (!token) {
        return NextResponse.redirect(new URL('/admin/login', req.url))
      }
    }

    return NextResponse.next()
  },
  {
    callbacks: {
      authorized: ({ token, req }) => {
        const { pathname } = req.nextUrl
        // Allow login page always
        if (pathname.startsWith('/admin/login')) return true
        // Admin pages require token
        if (pathname.startsWith('/admin')) return !!token
        // API routes - handled by individual route guards
        return true
      },
    },
  }
)

export const config = {
  matcher: ['/admin/:path*', '/api/projects/:path*', '/api/blog/:path*', '/api/team/:path*', '/api/upload/:path*'],
}
