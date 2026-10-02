#!/usr/bin/env bash
# Восстановление среды разработки 1С в облачной сессии Claude.
# Запуск: bash tools/setup.sh   (из корня репозитория)
set -euo pipefail
KIT="$(cd "$(dirname "$0")" && pwd)"

echo "== rlm-tools-bsl (анализ кода 1С)"
command -v rlm-tools-bsl >/dev/null || uv tool install rlm-tools-bsl

echo "== BSL Language Server (проверка кода)"
mkdir -p "$HOME/tools/bsl-ls"
if [[ ! -f "$HOME/tools/bsl-ls/bsl-ls.jar" ]]; then
  T=$(git ls-remote --tags --refs https://github.com/1c-syntax/bsl-language-server \
      | awk -F/ '{print $3}' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1)
  curl -sSL -o "$HOME/tools/bsl-ls/bsl-ls.jar" \
    "https://github.com/1c-syntax/bsl-language-server/releases/download/$T/bsl-language-server-${T#v}-exec.jar"
fi

chmod +x "$KIT"/*.sh
echo "== Готово:"
echo "   rlm-tools-bsl $(rlm-tools-bsl --version 2>/dev/null || true)"
echo "   BSL LS: $HOME/tools/bsl-ls/bsl-ls.jar"
