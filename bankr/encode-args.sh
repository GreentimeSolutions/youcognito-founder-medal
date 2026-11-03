#!/usr/bin/env bash
# Usage: ./encode-args.sh <recipient> [royaltyReceiver|0x0000000000000000000000000000000000000000]
# Constructor: (address recipient, address royaltyReceiver). Royalty 0x0 = no royalty.
set -euo pipefail
R=${1:?recipient}; Y=${2:-0x0000000000000000000000000000000000000000}
cast abi-encode "constructor(address,address)" "$R" "$Y" | tee constructor-args.hex
