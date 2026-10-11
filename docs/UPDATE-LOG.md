# Update log

Newest first. One entry per weekly session.

## 2026-10-11 — Full redesign (initial build)

- Replaced the placeholder site with a new design: home page, four game landing pages (blackjack, video poker, roulette, slots), strategy guide index, first guide (blackjack basic strategy), support, privacy, 404.
- Added SEO plumbing: titles/descriptions per page, canonical URLs, Open Graph + Twitter cards, OG image, JSON-LD (MobileApplication, Organization, WebSite, FAQPage, BreadcrumbList, Article), sitemap.xml, robots.txt, web manifest, Smart App Banner meta.
- Exported and optimized artwork from the app repo: app icon, logo, five theme logos, four game icons, chips, seven App Store screenshots as WebP.
- Wrote this playbook and log.
- Added `scripts/verify.sh` and the three-gate double check. The weekly routine now pushes straight to `main` after the gates pass.
