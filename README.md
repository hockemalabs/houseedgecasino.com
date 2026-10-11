# houseedgecasino.com

Marketing site for [House Edge Casino](https://apps.apple.com/us/app/house-edge-casino/id6758695813), the iOS casino simulator and strategy trainer by Hockema Labs LLC.

Static HTML, CSS, and a little vanilla JS. Served by GitHub Pages from the `main` branch at the custom domain in `CNAME`. No build step.

## Layout

```
index.html                      Home: hero, games, Learn Mode, screenshots, themes, pricing, FAQ
blackjack.html                  Game landing pages (one per game, SEO-targeted)
video-poker.html
roulette.html
slots.html
guides/index.html               Strategy guide index
guides/*.html                   Individual guides (long-form SEO articles)
support.html                    Support page (bug reports, feature requests, email)
privacypolicy.html              Privacy policy (content mirrors the App Store listing)
404.html                        Not-found page (GitHub Pages serves this automatically)
sitemap.xml, robots.txt         SEO plumbing. Update sitemap lastmod when a page changes.
site.webmanifest                Icons and theme color
assets/css/site.css             All styles (design tokens at the top)
assets/js/site.js               Nav toggle, scroll reveal, footer year
assets/img/                     Optimized artwork exported from the app repo
docs/WEEKLY-UPDATE-PLAYBOOK.md  How the weekly content/SEO update works
docs/UPDATE-LOG.md              Running log of what each weekly update did
```

Every page carries its own copy of the nav and footer. When you change either, change it in every `*.html` and `guides/*.html` file (grep for `nav-links` or `foot-grid`).

## Source of truth for app facts

The app repo is `hockemalabs/House-Edge-Casino`. Its `README.md` holds the App Store listing copy, and the Swift source holds the real rules and pricing. Do not describe features that are not in that repo.

## Local preview

```
python3 -m http.server 8000
```

Then open http://localhost:8000/. Absolute paths (`/assets/...`) are used throughout, so preview from the repo root.
