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
HTML_FILES=(index.html toolkit.html lista-espera-gracias.html curso-1-loops-compilador.html curso-2-arquitectura-hexagonal.html curso-3-soberania-local.html)

# 1. Every HTML file exists
echo "[ File existence ]"
for f in "${HTML_FILES[@]}"; do
    [ -f "$f" ] && pass "$f exists" || fail "$f is missing"
done

# 2. Every HTML file listed in README.md
echo ""
echo "[ HTML files listed in README.md ]"
for f in "${HTML_FILES[@]}"; do
    grep -q "$f" README.md && pass "$f listed in README.md" || fail "$f not listed in README.md"
done

# 3. No unfilled placeholders in docs
echo ""
echo "[ No unfilled placeholders ]"
for doc in README.md CHANGELOG.md VISITORS_GIFT.md; do
    if grep -q '<user>\|<repo>' "$doc"; then
        fail "$doc contains unfilled <user>/<repo> placeholders"
    else
        pass "$doc has no unfilled placeholders"
    fi
done

echo
echo "=== Parser-based HTML check ==="
if command -v python3 >/dev/null 2>&1; then
  if ! python3 tools/html_checker.py; then
    ERRORS=$((ERRORS + 1))
  fi
else
  echo "python3 not found. Skipping robust HTML checks."
fi
echo ""
if [ "$ERRORS" -eq 0 ]; then
    echo "✓ All checks passed."
else
    echo "✗ $ERRORS check(s) failed. Fix before pushing."
fi
echo ""

exit $ERRORS
