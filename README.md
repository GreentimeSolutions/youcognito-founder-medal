# Youcognito Founder's Medal (1 of 1)

Single-token ERC-721 on Base. Mints exactly one token (#1) at deploy to the recipient; no further minting, no admin controls. Art is fully on-chain SVG. 5% ERC-2981 royalty.

- Target: `src/FounderMedal.sol:FounderMedal`
- Compiler: `v0.8.24+commit.e11b9ed9`, optimizer enabled, 200 runs, evmVersion cancun (see `bankr/input.json`)
- Creation bytecode keccak256: `0xed21f410b6cc913d05ee05fcb26f41b37a3e54a39579c105ab94e38034a15496`
- Constructor args (abi-encoded, `bankr/constructor-args.hex`): recipient = royalty receiver = `0xa959d8eeded6fb440ca584d1e87e581168bbf628`

Files: `bankr/` deploy package (bytecode, standard-json input, constructor args, ABI, artifact), `contract/` sources and tests, `final-a.png` approved art preview.
