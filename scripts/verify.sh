#!/usr/bin/env bash
# Mechanical pre-push checks for houseedgecasino.com.
# Run from the repo root: bash scripts/verify.sh
# Exit code 0 = all checks passed. Anything else = do not push.
set -u
cd "$(dirname "$0")/.."
fail=0
note() { echo "  - $1"; }
err()  { echo "FAIL: $1"; fail=1; }

pages=$(ls *.html guides/*.html 2>/dev/null)

echo "== Required elements on every page"
for f in $pages; do
  case "$f" in 404.html) ;; *)
    grep -q 'id6758695813' "$f" || err "$f is missing the App Store link (id6758695813)"
    ;;
  esac
  grep -q 'entertainment and educational purposes only' "$f" || err "$f is missing the footer disclaimer"
  grep -q 'Intended for users 17+' "$f" || err "$f is missing the 17+ note"
  grep -q '<link rel="canonical"' "$f" || err "$f has no canonical link"
  grep -q '<meta name="description"' "$f" || err "$f has no meta description"
  [ "$(grep -c '<h1' "$f")" = "1" ] || err "$f must have exactly one <h1>"
  grep -q 'id="navLinks"' "$f" || err "$f is missing the shared nav"
  grep -q 'class="foot-grid"' "$f" || err "$f is missing the shared footer"
  grep -q '/assets/js/site.js' "$f" || err "$f does not load site.js"
done

echo "== Support email and store link unchanged"
grep -rl 'mailto:' --include=*.html . | while read f; do
  grep -o 'mailto:[^"]*' "$f" | grep -v 'support@houseedgecasino.com' | while read bad; do err "$f has an unexpected email: $bad"; done
done
grep -rho 'apps\.apple\.com[^"]*' --include=*.html . | sort -u | grep -v 'id6758695813' | while read bad; do err "unexpected App Store URL: $bad"; done

echo "== Forbidden language (real-money implications and promises of winning)"
# Real-money implications, plus promises or implied outcomes we never make.
pattern='real cash|win real money|real-money winnings|cash out|withdraw your winnings|get rich|sweepstakes|guarantee[ds]? (you|a|to) win|you (will|.ll) win|win more|win big|beat the (house|casino|dealer|odds)|overcome the house edge|can.t lose|never lose|make money|turn a profit|profitable system|winning (system|strategy|formula)|sure thing|works every time|proven system'
for f in $pages; do
  if grep -iqE "$pattern" "$f"; then
    err "$f contains forbidden language:"; grep -ioE "$pattern" "$f" | sort -u | sed 's/^/      /'
  fi
done

echo "== Fabrication guards (ratings, review counts, download counts)"
for f in $pages; do
  if grep -iqE 'aggregateRating|ratingValue|reviewCount|[0-9,.]+\+? (downloads|users|players)|[0-9]\.[0-9] stars' "$f"; then
    err "$f contains rating/review/download figures that cannot be verified"
  fi
done

echo "== Internal links and assets resolve"
for f in $pages; do
  grep -oE '(href|src|srcset)="[^"]+"' "$f" | grep -oE '"[^"]+"' | tr -d '"' | tr ',' '\n' \
    | sed 's/ [0-9]*w$//;s/^ *//' | grep -E '^/' | sed 's/[#?].*//' | sort -u | while read u; do
      [ -z "$u" ] && continue
      t="${u#/}"; [ -z "$t" ] && t=index.html; [ -d "$t" ] && t="$t/index.html"
      [ -f "$t" ] || err "$f links to missing path $u"
    done
done

echo "== Sitemap"
for f in $pages; do
  case "$f" in 404.html) continue;; esac
  u="/$f"; u="${u%index.html}"
  grep -q "<loc>https://houseedgecasino.com${u}</loc>" sitemap.xml || err "sitemap.xml is missing $u"
done
grep -o '<loc>[^<]*</loc>' sitemap.xml | sed 's|<loc>https://houseedgecasino.com||;s|</loc>||' | while read u; do
  t="${u#/}"; [ -z "$t" ] && t=index.html; [ -d "$t" ] && t="$t/index.html"
  [ -f "$t" ] || err "sitemap.xml lists $u but no such page exists"
done
python3 -c "import xml.dom.minidom,sys; xml.dom.minidom.parse('sitemap.xml')" 2>/dev/null || err "sitemap.xml is not well-formed XML"

echo "== JSON-LD parses"
for f in $pages; do
  python3 - "$f" <<'PY' || err "$f has invalid JSON-LD"
import re, sys, json
html = open(sys.argv[1], encoding='utf-8').read()
for block in re.findall(r'<script type="application/ld\+json">(.*?)</script>', html, re.S):
    json.loads(block)
PY
done

echo "== Image sizes (WebP under 120 KB, no raw PNG screenshots)"
find assets/img -name '*.webp' -size +120k | while read f; do err "$f is over 120 KB"; done
find assets/img -name '*.png' -size +450k | while read f; do err "$f is a large PNG; convert to WebP"; done
find . -path ./.git -prune -o -name '*.png' -size +1M -print | while read f; do err "$f is over 1 MB"; done

echo "== CSS tokens untouched"
grep -q -- '--gold: #f3c447;' assets/css/site.css || err "design token --gold was changed"
grep -q -- '--bg: #0c0a14;' assets/css/site.css || err "design token --bg was changed"

echo "== Update log has an entry dated today or later than the last one"
head -20 docs/UPDATE-LOG.md | grep -qE '^## [0-9]{4}-[0-9]{2}-[0-9]{2}' || err "docs/UPDATE-LOG.md has no dated entry at the top"

if [ "$fail" = "0" ]; then echo; echo "ALL CHECKS PASSED"; else echo; echo "CHECKS FAILED - do not push"; fi
exit $fail
