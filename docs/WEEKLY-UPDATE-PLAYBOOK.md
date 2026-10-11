# Weekly update playbook for houseedgecasino.com

This document drives the scheduled weekly session that keeps houseedgecasino.com fresh, accurate, and growing in search. Read it top to bottom before changing anything.

## Goal

Every week, write a new article or substantively update an existing one that genuinely interests the player base: people who enjoy casino games and want to understand them better. Each article teaches a real technique or concept and shows, honestly, how House Edge Casino can be used to practice or learn it. The article is the main weekly deliverable; the freshness check and small site improvements ride along with it. Quality over quantity: one well-written, accurate article beats three thin ones.

## Article standards

**Audience.** Casual and intermediate casino players, and people curious about the games before a trip. Assume intelligence, not expertise. Explain the math; do not hide it.

**Angle.** Every article has one concrete thing the reader can practice: a strategy decision, a bet type, a pay-table skill, a bankroll habit, a misconception to unlearn. Then show how to practice it in the app, naming the actual feature: Learn Mode hints, the strategy chart, the perfect-move streak, Vegas vs Fun odds, the "Understanding Casino Games" lessons, run statistics, tutorials. The tie-in is "practice until it is automatic, with nothing at risk," never "use the app and you will win."

**Length and shape.** 900 to 1,600 words. One H1, descriptive H2s, tables for odds and pay tables, a short FAQ, a download callout. Follow the page recipe below.

**Voice.** Direct, warm, specific. No hype, no exclamation marks, no filler.

## Claims policy (read this twice)

The site must never make a false statement, give bad advice, or promise an outcome. Concretely:

- **Never promise results.** No "you'll win more," "beat the house," "beat the casino," "come out ahead," "turn the odds in your favor," "guaranteed," "can't lose," or any phrasing that implies playing better leads to profit. The honest framing is: optimal play lowers the house edge, loses less over time, and makes the game last longer. Every game in the app still favors the house, and articles say so when relevant.
- **Never present a betting system as effective.** Martingale, Fibonacci, d'Alembert, "due" numbers, hot and cold machines, streak betting: these do not change expected value. They may be explained only to show why they fail.
- **Card counting:** it may be described as a real technique with a thin edge under specific real-world conditions, but the app does not teach counting, so do not sell it as something to practice there. Basic strategy is the foundation and that is what the app coaches.
- **Advice must be the standard, published, math-based advice** (basic strategy charts, Jacks or Better hold rankings, true odds vs payouts). If a figure cannot be stated with confidence, leave it out rather than guess. Cite the rule set the figure depends on (decks, dealer soft 17, pay table).
- **Bankroll advice is conservative:** play with money you can afford to lose, set a session budget and time limit, never chase losses, treat the cost as entertainment. Never suggest bet sizing or play duration as a way to recover or profit.
- **No encouragement to gamble more, longer, or with real money.** The app is a simulator for practice and entertainment; the site does not funnel people to real-money play.
- **App claims must match the app.** Only describe features, rules, prices, and balances that exist in the House-Edge-Casino repo today.
- **No fabricated social proof:** no ratings, review counts, download numbers, quotes, or testimonials.
- **Keep the disclaimer** in the footer of every page and the 17+ note. Articles about any game include at least one sentence that the house always has an edge.

The independent fact-check reviewer in Gate 3 is told to hunt specifically for violations of this policy. Fix every one it finds.

## Ground rules

1. **Accuracy first.** Every claim about the app must be verifiable in the `hockemalabs/House-Edge-Casino` repo (README.md for the App Store listing, Swift source for rules, pricing, balances, and themes). Never invent features, stats, ratings, review counts, or download numbers. Never fabricate testimonials.
2. **Compliance.** The app is a simulated casino rated 17+. Keep the disclaimer in the footer on every page. Never imply real-money winnings, never target minors, never use language like "win real cash." Keep "no real money" visible on landing pages.
3. **Stay in the design system.** Use the existing classes in `assets/css/site.css`. Add new CSS only when a component genuinely does not exist. Do not change the color tokens or fonts.
4. **Static site.** No build tools, frameworks, trackers, or third-party scripts. Images go in `assets/img/` as optimized WebP (ImageMagick `convert ... -resize 720x -quality 82`). Keep each new image under 120 KB.
5. **Push straight to `main`, but only after the double check passes.** The owner does not review these updates, so the verification gate below is the review. A change that fails any part of it does not ship that week.
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
5. Append the entry to `docs/UPDATE-LOG.md`.
6. **Run the double check** (next section). Fix everything it finds and run it again until it is clean.
7. Commit on `main`, `git pull --rebase origin main`, run `bash scripts/verify.sh` once more, then `git push origin main`. GitHub Pages deploys within a few minutes. Load https://houseedgecasino.com/ and the new page afterward to confirm they are live and not broken; if the live site is broken, fix forward immediately.

## The double check (mandatory before every push)

Three independent gates. All three must pass.

**Gate 1: mechanical checks.** Run `bash scripts/verify.sh` from the repo root. It checks every page for the disclaimer, the 17+ note, the App Store link, canonical and description tags, exactly one H1, the shared nav and footer; that all internal links and assets resolve; that the sitemap matches the pages; that JSON-LD parses; that no page contains real-money language or unverifiable rating/download figures; that images are optimized; and that the design tokens are untouched. Exit code 0 is a pass.

**Gate 2: render check.** Serve locally with `python3 -m http.server 8765` and use Playwright/Chromium (`require('playwright')`, `NODE_PATH=/opt/node-tools/node_modules` if needed) to load every page you changed at 1400px and 390px widths with `networkidle`. Fail on any console error, any 4xx/5xx response, or any horizontal overflow at 390px (`document.documentElement.scrollWidth > 390`). Take a full-page screenshot of each and look at it. Text overlapping, missing images, or an empty section is a fail.

**Gate 3: independent fact check.** Spawn a separate reviewer agent (the Agent tool) with a fresh context. Give it only: the `git diff` of your changes, the path to the app repo, and this instruction: "You are fact-checking marketing copy for an iOS app before it is published. For every factual claim about the app in this diff (rules, odds, pay tables, prices, balances, themes, features, device support, counts), find the evidence in the app repo (README.md, Swift source under 'House Edge Casino/', theme.json files, the Xcode project) and quote the file and line. For every strategy or math claim (house edges, probabilities, basic strategy plays, payouts), verify it against the standard published figures you know. Report a numbered list: each claim, VERIFIED with evidence, or UNVERIFIED/WRONG with what the evidence actually says. Separately, review the advice itself as a gambling-math expert would: flag any recommendation that is wrong, that presents a betting system or superstition as effective, that encourages gambling more or longer, or that a careful expert would call harmful. Flag every sentence that promises or implies the reader will win, profit, beat the house, or come out ahead, including soft versions like 'turn the odds in your favor.' Flag anything that implies real-money gambling or targets minors. Be adversarial. Do not approve a claim you could not trace." Every UNVERIFIED or WRONG item must be fixed or removed, then re-run the reviewer on the new diff until it reports zero problems. Do not skip this gate for "small" changes; a wrong number on a strategy page is exactly the kind of error that damages trust.

If any gate cannot be run (tooling missing, agent unavailable), do not push. Commit to a branch `weekly/YYYY-MM-DD` instead, push that branch, and report that the gate could not run.

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
15. Guide: **How to practice blackjack splits and doubles** (the decisions players get wrong most, drilled with Learn Mode hints on).
16. Guide: **Reading a video poker pay table in ten seconds** (what each row means, how to compare machines, why max coins matter).
17. Guide: **Inside vs outside roulette bets for beginners** (volatility, bankroll life, the same edge either way).
18. Guide: **What a perfect-move streak actually measures** (decision quality vs results, variance, why a long streak can still lose).
19. Guide: **Why "dealer hits soft 17" matters** (what it changes in the chart and in the edge).
20. Guide: **Slot paylines explained with the app's 25-line machine** (how lines pay, scatters, wilds, free spins).
21. Guide: **Setting a session budget and time limit** (ties to the app's Set a Budget, Time Limits, and Speed of Play lessons).
22. Guide: **Insurance and even money in blackjack: the same bad bet in two outfits.**
23. Ongoing after the backlog is exhausted: refresh the oldest guide with new sections, improve internal linking, tighten meta descriptions, add FAQ entries from real support questions in `hockemalabs/houseedgecasino-support` issues.

## Things to never do

- Never add analytics, ads, cookie banners, pop-ups, or newsletter capture without the owner asking.
- Never remove the footer disclaimer or the 17+ note.
- Never change the App Store link (`id6758695813`) or the support email.
- Never commit raw screenshots from the app repo without resizing and converting to WebP.
- Never push to `main` with any gate of the double check failing or unrun.
