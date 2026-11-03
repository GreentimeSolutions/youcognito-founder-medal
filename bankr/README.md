# Youcognito Founder's Medal — bankr package (NOT DEPLOYED)
- creation-bytecode.hex: 0x creation bytecode (art = variant baked by ../gen.py; currently variant a, placeholder until Andy picks)
- input.json: standard-json input with all sources; compiler-version.txt; contract-target.txt
- encode-args.sh <recipient> [royaltyReceiver] -> constructor-args.hex
Rebuild after picking art: cd .. && python3 gen.py <a|b|c> && cd contract && forge test && re-run packaging.
Mints #1 to recipient (not msg.sender) via _mint; no owner, no further minting.
