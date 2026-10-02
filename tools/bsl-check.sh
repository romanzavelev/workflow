#!/usr/bin/env bash
# Проверка BSL-кода через BSL Language Server.
#   bsl-check.sh <каталог>             — проверить весь каталог
#   bsl-check.sh --changed [репозиторий] — только .bsl, изменённые относительно HEAD (быстро для ERP)
set -euo pipefail
JAR="${BSL_LS_JAR:-$HOME/tools/bsl-ls/bsl-ls.jar}"
export LANG=C.UTF-8 LC_ALL=C.UTF-8
TMP=$(mktemp -d)
if [[ "${1:-}" == "--changed" ]]; then
  REPO="${2:-.}"; SRC="$TMP/src"; mkdir -p "$SRC"
  cd "$REPO"
  git -c core.quotepath=off diff --name-only HEAD -- '*.bsl' > "$TMP/list"
  git -c core.quotepath=off ls-files --others --exclude-standard -- '*.bsl' >> "$TMP/list"
  [[ -s "$TMP/list" ]] || { echo "Изменённых .bsl нет"; exit 0; }
  while IFS= read -r f; do [[ -f "$f" ]] && mkdir -p "$SRC/$(dirname "$f")" && cp "$f" "$SRC/$f"; done < "$TMP/list"
else
  SRC="$(realpath "${1:-.}")"
fi
mkdir -p "$TMP/out"
java -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -jar "$JAR" analyze -s "$SRC" -r json -o "$TMP/out" -q >/dev/null 2>&1 || true
python3 - "$TMP/out/bsl-json.json" "$SRC" <<'PY'
import json, sys, urllib.parse
data = json.load(open(sys.argv[1], encoding="utf-8")); root = sys.argv[2]
n = 0
for fi in data.get("fileinfos", []):
    path = urllib.parse.unquote(fi["path"]).replace("file://", "")
    path = path.split(root.rstrip("/") + "/", 1)[-1]
    for d in fi.get("diagnostics", []):
        n += 1
        code = d["code"]["left"] if isinstance(d["code"], dict) else d["code"]
        msg = d["message"]["left"] if isinstance(d["message"], dict) else d["message"]
        print(f'{path}:{d["range"]["start"]["line"]+1}  [{d["severity"]}] {code}: {msg}')
print(f"\nВсего замечаний: {n}")
PY
rm -rf "$TMP"
