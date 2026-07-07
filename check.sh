#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

ERRORS=0

pass() { echo "  ✓ $1"; }
fail() { echo "  ✗ $1"; ERRORS=$((ERRORS + 1)); }

echo ""
echo "=== PuppyTeach consistency check ==="
echo ""

# All HTML files in root
HTML_FILES=(index.html toolkit.html gracias.html lista-espera-gracias.html curso-1-hardware-secundario.html curso-2-savefiles.html curso-3-pipeline-trixieretro.html)

# 1. Every HTML file exists
echo "[ File existence ]"
for f in "${HTML_FILES[@]}"; do
    [ -f "$f" ] && pass "$f exists" || fail "$f is missing"
done

# 2. Every HTML file (except gracias.html) links back to index.html
echo ""
echo "[ Header nav links back to index.html ]"
for f in "${HTML_FILES[@]}"; do
    [ "$f" = "index.html" ] && continue
    [ "$f" = "gracias.html" ] && continue
    grep -q 'href="index.html"' "$f" && pass "$f" || fail "$f missing href=\"index.html\" in nav"
done

# 3. Every HTML file references styles.css and favicon.svg
echo ""
echo "[ styles.css and favicon.svg referenced ]"
for f in "${HTML_FILES[@]}"; do
    grep -q 'styles.css' "$f" && pass "$f → styles.css" || fail "$f missing styles.css"
    grep -q 'favicon.svg' "$f" && pass "$f → favicon.svg" || fail "$f missing favicon.svg"
done

# 4. puppyteach-capture-form only in toolkit.html
echo ""
echo "[ Form placement ]"
for f in "${HTML_FILES[@]}"; do
    [ "$f" = "toolkit.html" ] && continue
    if grep -q 'puppyteach-capture-form' "$f"; then
        fail "$f contains puppyteach-capture-form (should only be in toolkit.html)"
    else
        pass "$f does not contain puppyteach-capture-form"
    fi
done
grep -q 'puppyteach-capture-form' toolkit.html && pass "toolkit.html contains puppyteach-capture-form" || fail "toolkit.html is missing puppyteach-capture-form"

# 5. puppyteach-waitlist-form only in index.html
for f in "${HTML_FILES[@]}"; do
    [ "$f" = "index.html" ] && continue
    if grep -q 'puppyteach-waitlist-form' "$f"; then
        fail "$f contains puppyteach-waitlist-form (should only be in index.html)"
    fi
done
grep -q 'puppyteach-waitlist-form' index.html && pass "index.html contains puppyteach-waitlist-form" || fail "index.html is missing puppyteach-waitlist-form"

# 6. Every HTML file listed in README.md
echo ""
echo "[ HTML files listed in README.md ]"
for f in "${HTML_FILES[@]}"; do
    grep -q "$f" README.md && pass "$f listed in README.md" || fail "$f not listed in README.md"
done

# 7. No unfilled placeholders in docs
echo ""
echo "[ No unfilled placeholders ]"
for doc in README.md CHANGELOG.md VISITORS_GIFT.md; do
    if grep -q '<user>\|<repo>' "$doc"; then
        fail "$doc contains unfilled <user>/<repo> placeholders"
    else
        pass "$doc has no unfilled placeholders"
    fi
done

# 8. Every HTML file has a footer
echo ""
echo "[ Footer presence ]"
for f in "${HTML_FILES[@]}"; do
    grep -q '<footer>' "$f" && pass "$f has footer" || fail "$f is missing footer"
done

# 9. Internal href links — verify file exists AND anchor fragment exists on target page
echo ""
echo "[ Internal link integrity ]"
for f in "${HTML_FILES[@]}"; do
    while IFS= read -r href; do
        target="${href%%#*}"
        anchor="${href##*#}"
        # if no fragment, anchor == href (no # present); normalize
        [ "$anchor" = "$href" ] && anchor=""

        [ -z "$target" ] && continue
        if [ ! -f "$target" ]; then
            fail "$f links to missing file: $target"
            continue
        fi
        pass "$f → $target"

        if [ -n "$anchor" ]; then
            if grep -qP "id=\"${anchor}\"" "$target"; then
                pass "$f → $target#$anchor (anchor exists)"
            else
                fail "$f → $target#$anchor (anchor '#$anchor' not found in $target)"
            fi
        fi
    done < <(grep -oP 'href="\K[^"]+' "$f" | grep '\.html')
done

echo
echo "=== Parser-based HTML check ==="
if command -v python3 >/dev/null 2>&1; then
  python3 tools/html_checker.py || exit 1
fi
echo ""
if [ "$ERRORS" -eq 0 ]; then
    echo "✓ All checks passed."
else
    echo "✗ $ERRORS check(s) failed. Fix before pushing."
fi
echo ""

exit $ERRORS
