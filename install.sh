#!/usr/bin/env bash
#
# carpetbag installer.
#
# Usage (piped):
#   curl -fsSL https://raw.githubusercontent.com/mborsalino/carpetbag/main/install.sh | bash
#   curl -fsSL .../install.sh | bash -s -- md2
#   curl -fsSL .../install.sh | bash -s -- --prefix /opt/carpetbag md2
#
# Usage (cloned):
#   ./install.sh [--prefix DIR] [tool1 tool2 ...]
#
# Options:
#   --prefix DIR   Install tool binaries to $DIR/bin.
#                  Default: $HOME/.local (so binaries go to ~/.local/bin).
#                  Env var equivalent: CARPETBAG_PREFIX
#   -h, --help     Show this help.
#
# If no tools are listed, all known tools are installed. Tool names are the
# top-level directories of the carpetbag repo (each contains an executable
# of the same name).
#
set -euo pipefail

REPO_RAW="${CARPETBAG_REPO:-https://raw.githubusercontent.com/mborsalino/carpetbag/main}"
PREFIX="${CARPETBAG_PREFIX:-$HOME/.local}"

# Known tools. Maintain this list as new tools are added to the repo.
ALL_TOOLS=(md2)

usage() {
    sed -n '3,/^set -euo/p' "$0" | sed 's/^# \{0,1\}//' | head -n -1
    exit "${1:-0}"
}

# Parse args.
requested=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)   usage 0 ;;
        --prefix)    PREFIX="${2:?missing value for --prefix}"; shift 2 ;;
        --prefix=*)  PREFIX="${1#--prefix=}"; shift ;;
        -*)          echo "Error: unknown option: $1" >&2; usage 1 >&2 ;;
        *)           requested+=("$1"); shift ;;
    esac
done

if [[ ${#requested[@]} -eq 0 ]]; then
    tools=("${ALL_TOOLS[@]}")
else
    tools=("${requested[@]}")
fi

bin_dir="$PREFIX/bin"
mkdir -p "$bin_dir"

# Validate requested tools and install each.
for tool in "${tools[@]}"; do
    known=0
    for kt in "${ALL_TOOLS[@]}"; do
        [[ "$kt" == "$tool" ]] && known=1 && break
    done
    if [[ $known -eq 0 ]]; then
        echo "Error: unknown tool '$tool'. Known tools: ${ALL_TOOLS[*]}" >&2
        exit 1
    fi

    src_url="$REPO_RAW/$tool/$tool"
    dest="$bin_dir/$tool"
    echo "Installing $tool"
    echo "  from: $src_url"
    echo "  to:   $dest"
    curl -fsSL "$src_url" -o "$dest"
    chmod +x "$dest"
done

echo
echo "Done. Installed to: $bin_dir"
case ":$PATH:" in
    *":$bin_dir:"*) ;;
    *) echo "Note: $bin_dir is not on your PATH. Add it to your shell rc:"
       echo "      export PATH=\"$bin_dir:\$PATH\"" ;;
esac
