# Weekly update playbook for houseedgecasino.com

This document drives the scheduled weekly session that keeps houseedgecasino.com fresh, accurate, and growing in search. Read it top to bottom before changing anything.

## Goal

Every week, ship one meaningful improvement that helps people find the site and decide to download House Edge Casino. Quality over quantity: one well-written, accurate page beats three thin ones.

## Ground rules

1. **Accuracy first.** Every claim about the app must be verifiable in the `hockemalabs/House-Edge-Casino` repo (README.md for the App Store listing, Swift source for rules, pricing, balances, and themes). Never invent features, stats, ratings, review counts, or download numbers. Never fabricate testimonials.
2. **Compliance.** The app is a simulated casino rated 17+. Keep the disclaimer in the footer on every page. Never imply real-money winnings, never target minors, never use language like "win real cash." Keep "no real money" visible on landing pages.
3. **Stay in the design system.** Use the existing classes in `assets/css/site.css`. Add new CSS only when a component genuinely does not exist. Do not change the color tokens or fonts.
4. **Static site.** No build tools, frameworks, trackers, or third-party scripts. Images go in `assets/img/` as optimized WebP (ImageMagick `convert ... -resize 720x -quality 82`). Keep each new image under 120 KB.
5. **One branch, one PR, never push to main.** Branch from `main` as `weekly/YYYY-MM-DD`, commit, push, open a pull request titled `Weekly update: <what changed>`. The PR body lists what changed and why, plus the SEO target. Do not merge.
6. **Log it.** Append an entry to `docs/UPDATE-LOG.md` in the same PR so the next session knows what has been done.
7. **Do not repeat.** Read `docs/UPDATE-LOG.md` first and skip anything already done.

## The weekly procedure

1. Attach and clone both repos if the session does not already have them: `hockemalabs/houseedgecasino.com` (the site) and `hockemalabs/House-Edge-Casino` (the app, read-only reference).
2. Read `README.md`, this playbook, and `docs/UPDATE-LOG.md` in the site repo.
3. **Freshness check (every week, 10 minutes):**
   - Diff the app repo's `README.md` App Store section and `MARKETING_VERSION` in the Xcode project against what the site says (pricing, themes, games, features). Fix any drift.
   - Run a link check: every internal `href`/`src` must resolve to a file. Fix broken ones.
   - If any page changed, update its `<lastmod>` in `sitemap.xml`.
4. **Pick the next backlog item** (below, in order, skipping done items) and build it completely.
5. **Verify** by serving locally (`python3 -m http.server`) and rendering with Playwright/Chromium at 1400px and 390px widths. Fix anything broken before pushing.
6. Commit, push the branch, open the PR, append to the update log.

## Page recipe for a new strategy guide

- File: `guides/<slug>.html`. Copy the structure of `guides/blackjack-basic-strategy.html` exactly (head meta, nav, page-head with breadcrumbs, `.prose` article, FAQ section, CTA banner, footer).
- Length: 900 to 1,600 words of genuinely useful, math-based content. Tables for pay tables and odds. Plain English for the reasoning.
- SEO: one target query in the `<title>` (under 60 characters before the brand suffix), a 150 to 160 character meta description, one H1, descriptive H2s, Article + BreadcrumbList + FAQPage JSON-LD, canonical URL, OG tags.
- Tie-in: at least two natural links to the matching game page and one callout to download the app with Learn Mode on. The guide must connect to something the app actually does.
- Add the guide to the list in `guides/index.html` (the `GUIDES` card list) and to `sitemap.xml`. Link it from the related game page's strategy primer.

## Content backlog (work top to bottom)

1. Guide: **Video poker strategy for 9/6 Jacks or Better** (full hand-ranking strategy list with the reasoning, pay table, max-coin math).
2. Guide: **Every roulette bet explained** (American vs European, true odds vs payout, why systems like Martingale fail, with the numbers).
3. Guide: **How slot machines really work** (RNG, hit frequency vs return, volatility, paylines, why "due" is a myth).
4. Guide: **Bankroll management for casual casino play** (session budgets, bet sizing as % of bankroll, time limits; ties to the app's Time Limits and Set a Budget lessons).
5. Guide: **Blackjack mistakes beginners make** (insurance, splitting tens, standing on soft 17, hitting 12 vs 4-6).
6. Guide: **House edge of every casino game, ranked** (comparison table; the app's selection screen shows these numbers).
7. Guide: **Blackjack rule variations and what they cost** (H17 vs S17, 6:5 payouts, DAS, number of decks).
8. Guide: **Video poker pay tables: how to spot a full-pay machine** (9/6 vs 8/5 vs 7/5 returns).
9. Page: **Themes showcase** (`themes.html`): one section per theme with its logo and a screenshot from the app repo's `screenshots/` folder, if a clean per-theme screenshot exists. Verify the screenshot really shows that theme before using it.
10. Page: **What's new / changelog** (`whats-new.html`), driven by the app repo's recent merged PRs and release notes. Only list shipped, user-facing changes.
11. Home page: add a short **"How Learn Mode works"** three-step explainer with real in-app screenshots.
12. Guide: **Should you take even money on a blackjack?**
13. Guide: **Soft hands in blackjack, explained**
14. Guide: **Slots: Vegas odds vs Fun mode, what the app changes and why**
15. Ongoing after the backlog is exhausted: refresh the oldest guide with new sections, improve internal linking, tighten meta descriptions, add FAQ entries from real support questions in `hockemalabs/houseedgecasino-support` issues.

## Things to never do

- Never add analytics, ads, cookie banners, pop-ups, or newsletter capture without the owner asking.
- Never remove the footer disclaimer or the 17+ note.
- Never change the App Store link (`id6758695813`) or the support email.
- Never commit raw screenshots from the app repo without resizing and converting to WebP.
- Never merge your own PR or push to `main`.
