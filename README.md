# Business Config Template

A generic, sanitized starter for small businesses that need centralized branding and business configuration in a Next.js + Supabase project.

This repository is intentionally generic. It contains no real company credentials, payment secrets, customer data, or private business information.

## What this demonstrates

- Centralized business branding configuration
- Safe use of `NEXT_PUBLIC_*` environment variables
- Server-only secret configuration
- Optional Supabase business configuration table
- A starter SQL migration with Row Level Security
- A runtime `branding.json` fallback for simple configuration

## Important security rule

Never commit `.env.local`, Stripe secret keys, Supabase service-role keys, database passwords, or customer data.

Public variables such as a Supabase URL and anon key may be exposed to the browser, but database permissions must still be protected with RLS.

## Quick start

```bash
cp .env.example .env.local
npm install
npm run dev
```

This template is framework-neutral at the database level. Copy `lib/config.js` into a Next.js project, or adapt it to your framework.

## Supabase setup

1. Create a Supabase project.
2. Open **SQL Editor**.
3. Copy and run `supabase/schema.sql`.
4. Add the Supabase URL and anon key to `.env.local`.
5. Read the public configuration row using the Supabase client.

## Files

- `.env.example` — safe variable names and placeholders
- `public/branding.json` — optional runtime branding fallback
- `lib/config.js` — centralized configuration helper
- `supabase/schema.sql` — generic business configuration schema

## Configuration precedence

1. `public/branding.json` when available
2. Supabase `business_config` row when connected
3. `NEXT_PUBLIC_*` environment defaults
4. hard-coded safe fallback values

## License

MIT
