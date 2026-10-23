#!/bin/bash
# stuxgroup.github.io - dependency-free test runner.
# Run from anywhere with: bash tests/run.sh
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "ok   - $1"; }
fail() { FAIL=$((FAIL + 1)); echo "FAIL - $1"; }

# Date Versioning (https://datevers.ing): the UTC release date as YY.MM.DD,
# plus -1, -2... for later releases the same day.
DATEVER='^[0-9]{2}\.(0[1-9]|1[0-2])\.(0[1-9]|[12][0-9]|3[01])(-[1-9][0-9]*)?$'

# Real Gregorian calendar date check for YY.MM.DD (years 2000-2099), without relying on `date`.
is_real_date() {
    local yy mm dd year max
    [[ "$1" =~ ^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$ ]] || return 1
    IFS=. read -r yy mm dd <<< "$1"
    year=$((2000 + 10#$yy)); mm=$((10#$mm)); dd=$((10#$dd))
    case $mm in
        1|3|5|7|8|10|12) max=31 ;;
        4|6|9|11) max=30 ;;
        2) if (( (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 )); then max=29; else max=28; fi ;;
        *) return 1 ;;
    esac
    (( dd >= 1 && dd <= max ))
}

VERSION="$(tr -d '[:space:]' < "$ROOT/VERSION.md")"

if [[ "$VERSION" =~ $DATEVER ]]; then
    pass "VERSION.md ($VERSION) is a Date Version"
else
    fail "VERSION.md ($VERSION) is not a Date Version (YY.MM.DD or YY.MM.DD-N)"
fi

if is_real_date "${VERSION%%-*}"; then
    pass "VERSION.md ($VERSION) is a real calendar date"
else
    fail "VERSION.md ($VERSION) is not a real calendar date"
fi

NEWEST="$(grep -m1 -E '^## v' "$ROOT/CHANGELOG.md" | sed -E 's/^## v([^[:space:]]+).*/\1/')"
if [[ "$NEWEST" == "$VERSION" ]]; then
    pass "newest CHANGELOG.md entry (v$NEWEST) matches VERSION.md"
else
    fail "newest CHANGELOG.md entry (v$NEWEST) should be the version in VERSION.md ($VERSION)"
fi

# Self-checks for the calendar validator, so a broken helper can't pass silently.
for bad in 26.02.29 26.02.30 26.04.31 25.13.01; do
    if is_real_date "$bad"; then fail "is_real_date rejects $bad"; else pass "is_real_date rejects $bad"; fi
done
for good in 24.02.29 26.10.22 26.12.31; do
    if is_real_date "$good"; then pass "is_real_date accepts $good"; else fail "is_real_date accepts $good"; fi
done

echo
echo "$PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]]
