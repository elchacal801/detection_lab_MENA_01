# Detection Lab: Middle East APT Focus

**Mission**: A public, enterprise-credible portfolio demonstrating "Intel-to-Detection" capabilities. This repository contains structured intelligence, detection resources (YARA, Sigma, Suricata), and validation logic for simulating and detecting advanced tradecraft in a high-fidelity F500 financial environment.

> [!CAUTION]
> **Safety Disclosure**: This repository contains references to real-world malware tradecraft. While no live malware binaries are stored here, the detection logic and traffic patterns faithfully simulate malicious behavior. Use with caution and only in isolated test environments.

## Repository Structure

* **`packs/`**: Atomic units of intelligence and detection. Each subfolder represents a Threat Actor or specific Campaign (e.g., `muddywater-powerton`).
  * Contains the **Brief**, **Detections** (YARA/Sigma/Network), and **Validation** tests.
* **`library/`**: Shared detection logic and reusable rules (e.g., generic functional capability detection).
* **`docs/`**: Governance documents, including the *Detection Engineering Playbook* and *Lab Safety Policy*.
* **`reports/`**: Safe artifacts generated from analysis (strings, metadata, sterilized logs).

## Usage

1. **View Intelligence**: Start with the `packs/` directory to read Threat Actor Briefs.
2. **Deploy Detections**: Use the `.yml` (Sigma) or `.yar` (YARA) files in your SIEM/Scanner.
3. **Validate**: Run the provided test scripts in a safe VM to verify detection coverage.

## Project Status

* **Focus**: Middle East-themed APTs
* **Environment**: Simulated F500 Financial (Hybrid On-prem/Cloud)
* **Maintenance**: active

---
*Author: Candidate for Google GTIG (Threat Analyst – ME APT)*
