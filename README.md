# Solverex

**Every problem deserves a solution.**

Solverex is an X-connected social impact platform where people share real-world needs and others contribute resources, expertise, or support.

## Current milestone

This repository begins with a responsive **interactive product preview**, not a production-ready fundraising service. All sample problems and activity are illustrative. Demo posts and offers are stored in the browser only.

## Local development

```bash
npm install
npm run dev
```

Open http://localhost:3000.

## Stack

- Next.js App Router + React + TypeScript
- CSS design system
- Planned: Supabase Auth, Postgres, Storage and row-level security
- Planned: X OAuth (requires approved developer credentials)
- Deployment target: Vercel

## Important limits

- No real financial transactions, verified claims or active X integration in this preview
- Never publish sensitive verification documents or payment credentials
- No impact metrics should be represented as actual until measured
- An X login flow and cross-user persistent data require backend setup

## Planned MVP

1. X sign-in and user profiles
2. Create / edit problem requests
3. Discover by category
4. Offer resources or expertise
5. Admin review + abuse reporting
6. Outcome tracking

See `supabase/schema.sql` for a proposed starting database schema, not yet deployed.
