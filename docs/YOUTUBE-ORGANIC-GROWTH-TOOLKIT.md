# YouTube organic growth toolkit — isolated integration

**Status:** Installation helper prepared. No direct YouTube account authorization, metadata changes, production deployment, or automatic publishing.

## Why this path

This project already contains content strategy, SEO optimization, YouTube Analytics, Shorts repurposing, and controlled growth experiments. Avoid replacing those pipelines with another autonomous publisher. Add third-party **research and review** tools only when a measured capability is missing.

Reviewed option: [adityaarsharma/youtube-marketing-skills](https://github.com/adityaarsharma/youtube-marketing-skills), MIT-licensed. The project describes 21 marketing commands and an MCP server for live YouTube analytics and metadata editing.

The installer pins upstream commit `e9136cb39379a82801ee5ae542ff53a1d1109bd2` to avoid silently following latest code. **This is third-party code.** Audit before executing, review the declared npm dependencies, and do not install it with elevated privileges.

## Opt-in local installation

On macOS/Linux, from the root of this repository:

```bash
bash scripts/integrations/install-youtube-marketing-toolkit.sh
```

Requirements: Node.js 18+, Git, npm, and network access. The script checks out a pinned upstream revision under `.local-tools/youtube-marketing-skills` and runs `npm ci --ignore-scripts`. It does **not** run the MCP server, authenticate with Google, edit metadata, or install it into the production app.

Inspect the code and especially `auth.js`, `server.js`, and `package.json` before using the toolkit.

## Authorization and privacy warning

The upstream `auth.js` currently requests YouTube read, Analytics and **write/upload** scopes. The server also has write-capable tools. This is not a read-only integration. Never paste OAuth tokens, `credentials.json`, `tokens.json`, WordPress credentials, or Google API secrets into a chat or GitHub issue.

If using it locally, explicitly review Google's consent screen, limit scopes where possible, and verify the active channel ID before any write. Prefer read-only audits first, human review for every proposed edit, and backups of video metadata. Be aware that OAuth token files are stored on the local machine.

## Research-to-results workflow

1. Identify the authenticated channel by ID and handle; never switch channels without approval.
2. Export last 90 days of video-level views, impressions, CTR, retention, traffic sources, subscribers gained, and eligible public watch hours (separately).
3. Select 5-10 existing videos with **impressions but weak CTR**, or strong CTR but poor first-30-second retention. Do not use tag count as a growth KPI.
4. Draft 2-3 truthful, relevant title/thumbnail options and compare against current baseline; preserve existing description links and disclosures.
5. Obtain explicit approval before metadata writes; measure performance over comparable windows and revert weak changes.
6. For new uploads, prioritize topic fit, audience retention, thumbnail clarity, playlists, and original content; do not use bought views, view exchanges, or artificial engagement.
7. Review organic search + browse + suggested traffic separately. No external toolkit can guarantee subscribers, views, or monetization.

## Existing project issues

- `scripts/growth/snapshot-github.js` is **GitHub repository growth tracking** (stars, forks, traffic), not YouTube analytics; never interpret its output as video/channel growth.
- The previous GitHub Actions workflow listened to `master`, whereas the connected default branch is `main`; the workflow was corrected in this branch.
- A production-ready integration still requires a trusted runtime, correct Google Cloud OAuth credentials, API activation, and user consent. This PR does **not** represent a live installation.

## Himalayan Koh: separate website

Do **not** add WordPress/WooCommerce plugins to this YouTube application or to a production shop without backups, staging tests, and verification of quote-only wholesale, stock, shipping, and login behavior.
