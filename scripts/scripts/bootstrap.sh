#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
    pwd
)"

if ((EUID == 0)); then
    echo "Do not run this script as root. It will use sudo when needed." >&2
    exit 1
fi

case "$(uname -s)" in
Linux)
    "$SCRIPT_DIR/arch/install_apps.sh"
    #"$SCRIPT_DIR/arch/install_lazyvim.sh"
    ;;
Darwin)
    #"$SCRIPT_DIR/macos/install_apps.sh"
    #"$SCRIPT_DIR/macos/install_lazyvim.sh"
    ;;
*)
    echo "Unsupported operating system: $(uname -s)" >&2
    exit 1
    ;;
esac
