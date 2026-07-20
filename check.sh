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
for doc in README.md CHANGELOG.md VISITORS_GIFT.md ROADMAP.md TROUBLESHOOTING.md; do
    if grep -q '<user>\|<repo>' "$doc"; then
        fail "$doc contains unfilled <user>/<repo> placeholders"
    else
        pass "$doc has no unfilled placeholders"
    fi
done

echo
echo "=== Generated HTML drift check ==="
TMP_BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_BUILD_DIR"' EXIT
REAL_TOOLKIT_URL=$(grep -oP '(?<=href=")[^"]*' toolkit.html 2>/dev/null | grep -E 'https://github.com/.*/releases/download/' | head -1 || true)
if [ -z "$REAL_TOOLKIT_URL" ]; then
    REAL_TOOLKIT_URL="https://example.com/package.zip"
fi
if command -v python3 >/dev/null 2>&1; then
  if ! TOOLKIT_DOWNLOAD_URL="$REAL_TOOLKIT_URL" python3 tools/build.py --output-dir "$TMP_BUILD_DIR"; then
    ERRORS=$((ERRORS + 1))
  else
    python3 - "$DIR" "$TMP_BUILD_DIR" <<'PY'
import filecmp
import pathlib
import sys

root_dir = pathlib.Path(sys.argv[1])
tmp_dir = pathlib.Path(sys.argv[2])

template_files = list(root_dir.glob('*.html.template'))
if not template_files:
    sys.exit(0)

for template_path in template_files:
    output_name = template_path.name[:-9]
    built_path = tmp_dir / output_name
    committed_path = root_dir / output_name
    if not built_path.exists():
        print(f"  ✗ Missing generated output: {output_name}")
        sys.exit(2)
    if not committed_path.exists():
        print(f"  ✗ Missing committed output: {output_name}")
        sys.exit(2)
    if not filecmp.cmp(built_path, committed_path, shallow=False):
        print(f"  ✗ Generated file drift detected for {output_name}")
        print(f"    Run: bash build.sh")
        sys.exit(2)

print("  ✓ Generated HTML files match the current templates.")
PY
    if [ $? -ne 0 ]; then
      ERRORS=$((ERRORS + 1))
    fi
  fi
else
  echo "python3 not found. Skipping build drift checks."
fi

echo
echo "=== Parser-based HTML check ==="
if command -v python3 >/dev/null 2>&1; then
  if ! python3 tools/html_checker.py; then
    ERRORS=$((ERRORS + 1))
  fi
else
  echo "python3 not found. Skipping robust HTML checks."
fi

echo
echo "=== Comportamiento del modal (navegador real, opcional) ==="
if command -v python3 >/dev/null 2>&1; then
  if python3 -c "import playwright" >/dev/null 2>&1; then
    if ! python3 tools/test_toolkit_modal.py; then
      ERRORS=$((ERRORS + 1))
    fi
  else
    echo "Playwright no está instalado — se omite este chequeo."
    echo "Instalar con: pip install playwright --break-system-packages && playwright install chromium"
  fi
else
  echo "python3 not found. Skipping browser modal checks."
fi
echo ""
if [ "$ERRORS" -eq 0 ]; then
    echo "✓ All checks passed."
else
    echo "✗ $ERRORS check(s) failed. Fix before pushing."
fi
echo ""

exit $ERRORS
