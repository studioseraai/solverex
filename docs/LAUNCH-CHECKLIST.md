# Solverex launch checklist

## Implemented (frontend demo)
- [x] Responsive marketing homepage
- [x] Responsive application workspace at /workspace
- [x] Category filters, keyword search, request detail drawer
- [x] Create demo request, image preview, saved requests
- [x] Offer-help and report forms (local only)
- [x] Profile editing (local only)
- [x] Demo moderation and resolution statuses (local only)
- [x] Messages, activity notifications, and admin dashboard (local-only simulations)
- [x] Demo reset control and image size limits
- [x] CI build workflow added

## Not implemented until backend phase
- [ ] Supabase project + apply reviewed SQL schema
- [ ] Real authentication and X OAuth credentials
- [ ] Real cross-user messaging and delivery notifications
- [ ] Server-side permissioned moderation and anti-fraud controls
- [ ] Cross-user persistent posts, real offers and notifications
- [ ] Private evidence storage and appropriate identity verification
- [ ] Abuse reporting backend, rate limiting, privacy policy
- [ ] Vercel deployment, domain and production environment variables
- [ ] Accessibility, browser and mobile QA
- [ ] Actual payment processor integration (future phase)

## Preview instructions
`npm install && npm run dev` then visit `/workspace`.
Sample posts are fictional. New requests are stored in browser localStorage, not sent to other users.
The UI is not production-ready and should not solicit real funds or sensitive information.
