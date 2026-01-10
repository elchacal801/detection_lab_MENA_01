# RustyWater Implant

## Overview

RustyWater is a Rust-based implant used by the MuddyWater APT group (also known as MERCURY, Static Kitten). It has been observed in spear-phishing campaigns targeting the Middle East.

## Technical Details

- **Language**: Rust
- **Delivery**: Malicious Word documents with embedded VBA macros (Stage 1) dropping `CertificationKit.ini` (Stage 2).
- **C2 Communication**: Uses the Rust `reqwest` library for HTTP communication.
- **Key Indicator**: The default User-Agent string `reqwest/` is used, identifying the library usage which is distinct from typical browser User-Agents.
- **Capabilities**: System enumeration, file listing, command execution via `cmd.exe`.

## References

- [CloudSEK: Reborn in Rust](https://www.cloudsek.com/blog/reborn-in-rust-muddywater-evolves-tooling-with-rustywater-implant)
