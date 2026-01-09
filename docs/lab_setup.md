# Lab Setup & Safety Policy

## 1. Safety Principles

* **Isolation**: Malware is analyzed ONLY in isolated Virtual Machines (VMs) with "Host-Only" networking or strict segregation.
* **No Contamination**: Never analyze samples on a host with personal credentials, production access, or cached logins.
* **No Destruction**: Do not execute potential wipers or ransomware even in VMs without snapshots ensuring recoverability.
* **Safe Artifacts**: This repo strictly forbids live malware binaries (`.exe`, `.dll`). Only hashes, metadata, and sanitized text artifacts are allowed.

## 2. Lab Environment

* **Hypervisor**: VMware Workstation / VirtualBox
* **Operating Systems**:
  * Windows 10 Enterprise (Evaluation) for Endpoint analysis.
  * Remnux (Linux) for Network/Static analysis.
* **Tools**:
  * *Static*: PEStudio, Floss, Capa, Strings
  * *Dynamic*: Procmon, Wireshark, Fiddler, Sysmon (SwiftOnSecurity Config)
  * *Disassembly*: Ghidra

## 3. Data Handling

1. **Download**: Use Tor or a non-attributable VPN when pulling samples from VX-Underground/MalwareBazaar.
2. **Storage**: Samples are kept in a password-protected ZIP (`infected` / `infected`) outside this repo.
3. **Sanitization**: Before committing analysis notes, REDACT any hardcoded API keys, internal IP addresses, or Personally Identifiable Information (PII) if analyzing private captures.
