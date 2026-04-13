#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  DevSphere — Tax Calculator Task
#  Test runner (ubuntu-latest / Swift on Linux)
# ─────────────────────────────────────────────────────────────
set -uo pipefail

PASS=0
FAIL=0
ERRORS=""

# ── Helpers ──────────────────────────────────────────────────
pass() { echo "  ✅  $1"; ((PASS++)); }
fail() { echo "  ❌  $1"; ((FAIL++)); ERRORS="$ERRORS\n  • $1"; }

# ── Locate TaxLogic.swift ─────────────────────────────────────
TAX_LOGIC=$(find . -name "TaxLogic.swift" ! -path "*/tests/*" | head -1)
if [[ -z "$TAX_LOGIC" ]]; then
  echo "❌  TaxLogic.swift not found in the repository."
  exit 1
fi
echo "Found: $TAX_LOGIC"

# ── Compile: TaxLogic + test harness ─────────────────────────
BINARY="$(mktemp -d)/tax_tests"
if ! swiftc "$TAX_LOGIC" tests/main.swift tests/TaxLogicTests.swift -o "$BINARY" 2>&1; then
  echo ""
  echo "❌  Compilation failed — fix the Swift errors above."
  exit 1
fi
echo "Compiled OK."
echo ""

# ── Run compiled test binary and capture output ───────────────
OUTPUT=$("$BINARY" 2>&1)
EXIT_CODE=$?
echo "$OUTPUT"

# ── Parse result lines from the binary ───────────────────────
while IFS= read -r line; do
  if [[ "$line" == *"[PASS]"* ]]; then
    ((PASS++))
  elif [[ "$line" == *"[FAIL]"* ]]; then
    ((FAIL++))
    ERRORS="$ERRORS\n  • $line"
  fi
done <<< "$OUTPUT"

# ── Summary ───────────────────────────────────────────────────
echo ""
echo "══════════════════════════════════"
echo "  Results: $PASS passed, $FAIL failed"
echo "══════════════════════════════════"

if [[ $FAIL -gt 0 ]]; then
  echo ""
  echo "Failed tests:"
  printf '%b\n' "$ERRORS"
  exit 1
fi

exit 0