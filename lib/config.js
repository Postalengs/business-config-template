export const defaultBusinessConfig = {
  name: process.env.NEXT_PUBLIC_BUSINESS_NAME || 'Example Business',
  phone: process.env.NEXT_PUBLIC_BUSINESS_PHONE || '(555) 555-0100',
  email: process.env.NEXT_PUBLIC_BUSINESS_EMAIL || 'hello@example.com',
  logoUrl: process.env.NEXT_PUBLIC_LOGO_URL || '/logo-placeholder.svg',
  location: process.env.NEXT_PUBLIC_DEFAULT_LOCATION || 'Main Location',
  colors: {
    primary: process.env.NEXT_PUBLIC_PRIMARY_COLOR || '#111827',
    secondary: process.env.NEXT_PUBLIC_SECONDARY_COLOR || '#6B7280',
    accent: process.env.NEXT_PUBLIC_ACCENT_COLOR || '#2563EB'
  }
}

/**
 * Client-safe configuration loader for a Next.js app.
 *
 * This reads public/branding.json first and falls back to environment defaults.
 * Do not put server secrets in this file or in NEXT_PUBLIC_* variables.
 */
export async function getBusinessConfig() {
  try {
    const response = await fetch('/branding.json', { cache: 'no-store' })

    if (response.ok) {
      const runtimeConfig = await response.json()
      return {
        ...defaultBusinessConfig,
        ...runtimeConfig,
        colors: {
          ...defaultBusinessConfig.colors,
          ...(runtimeConfig.colors || {})
        }
      }
    }
  } catch {
    // Use environment defaults when the runtime file is unavailable.
  }

  return defaultBusinessConfig
}

/**
 * Server-only configuration. Import this only from server code or API routes.
 */
export function getServerConfig() {
  return {
    supabaseServiceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY || '',
    stripeSecretKey: process.env.STRIPE_SECRET_KEY || ''
  }
}
