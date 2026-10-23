# YouTube Automation Studio — Master Progress

Branch: `feat/production-readiness`
Goal: one Freebuff-hosted control center with secure auth, database, environment management, n8n automation, AI video production, persistent workers and YouTube integration.

## Phase status

| # | Phase | Status | Evidence |
|---|-------|--------|----------|
| 0 | Audit and branch setup | Done | Branch created; CI retargeted from `master` to `main` (commit `8666c0e`) |
| 1 | Fail-closed API authentication | Done (core) | `requireAPIKey` returns 503 when `API_KEY` is unset and 401 on a wrong key; key compared in constant time; read routes that were unguarded (`/analytics`, `/schedule`, `/api/outcomes`, `/api/dashboard`, `/api/jobs/:id`, `/api/readiness`, `/api/content/*` reads, `/api/experiments`, `/api/retention/*`, `/api/engagement/*`) now require the key. Auth test asserts fail-closed behaviour. |
| 2 | Persistent storage | Not started | Still SQLite via `database/db.js`; not verified on any hosted target |
| 3 | Durable job queue | Not started | Jobs persist in SQLite; no worker lease/retry queue yet |
| 4 | Worker connectivity | Not started | — |
| 5 | Dashboard | Partial | Existing dashboard works with `x-api-key`; no Freebuff sign-in yet |
| 6 | Freebuff sign-in | Not started | Requires Freebuff sign-in setup (`sites_enable_auth`) |
| 7 | Environment and secrets management | Not started | `.env` used locally; no hosted secret store yet |
| 8 | n8n integration | Not started | — |
| 9 | AI production | Not started | — |
| 10 | Real MP4 rendering verification | Not started | — |
| 11 | Restart recovery | Not started | — |
| 12 | YouTube integration | Not started | — |
| 13 | Analytics | Not started | — |
| 14 | Persistent worker deployment | Not started | — |
| 15 | Hosted deployment (preview only) | Not started | — |
| 16 | Final verification and PR | In progress | PR to `main` pending; not merged |

## Test evidence

- `npm test`: 45 passed, 0 failed (after the auth change).
- `npm run lint`: exit 0.

## Known gaps

- Media asset routes (`/api/content/*/asset/*`, `/api/content/*/shorts/*/asset/*`) are still public. The dashboard loads them via plain `<img>` and `<video>` tags, which cannot send `x-api-key`. Fixing this needs signed or short-lived asset URLs.
- CI has not been verified on GitHub yet.
- Portfolio issue #5 (broken FeaturedProjects link) is left until the new backend is live, as chosen.

## Blockers

- Freebuff sign-in and hosting need to be set up on the Freebuff side before Phase 6 and Phase 15.
- YouTube, n8n and AI provider credentials must be placed in `.env` by the owner. They will not be requested in chat.

## Next executable steps

1. Replace the shared `x-api-key` with per-user sign-in (Phase 6) once Freebuff sign-in is configured.
2. Replace the public asset routes with signed, short-lived URLs.
3. Add a durable job table with leases, retries and restart recovery (Phases 3 and 11).
4. Verify CI on GitHub after the PR is opened.
