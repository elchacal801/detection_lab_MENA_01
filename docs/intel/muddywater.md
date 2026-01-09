# Threat Group Profile: MuddyWater

> [!NOTE]
> **Aliases**: MERCURY, Static Kitten, Seedworm, EMP.ZAGROS, TA450
> **Attribution**: Iran (Subordinate to Ministry of Intelligence and Security - MOIS)
> **Active Since**: ~2017

## 1. Executive Overview

MuddyWater is a prolific Iranian cyber-espionage group known for targeting government, telecommunications, energy, and oil/gas sectors in the **Middle East** (Israel, Iraq, Saudi Arabia, UAE, Jordan), **Turkey**, and **Azerbaijan**.

Unlike IRGC-linked groups (like APT33/APT34) which often use sophisticated custom backdoors, MuddyWater is characterized by its heavy reliance on **"Living off the Land" (LotL)** techniques, scripting languages (PowerShell, Python), and publicly available Remote Monitoring & Management (RMM) tools.

In late 2023, the group shifted posture from purely espionage to **destructive operations** (Wiper malware) in response to regional conflicts.

---

## 2. Operational Toolset (The Arsenal)

### A. Custom Malware

* **POWERSTATS**: The group's signature PowerShell backdoor. Historically embedded in macro-laden Word documents. Capabilities include file upload/download, command execution, and taking screenshots.
* **MUDDYC2 (MuddyC3)**: A Python-based C2 framework used in earlier campaigns (deprecated in favor of simpler web shells and RMM).
* **BiBiWiper**: A highly destructive wiper (Windows/Linux variants) used to permanently destroy data by overwriting files with random bytes or the string "BiBi".
* **LIONTAIL**: A custom lightweight framework often installed as a Windows Service.

### B. Dual-Use & RMM Tools (Greyware)

MuddyWater aggressively utilizes legitimate software to blend in with admin activity:

* **Remote Access**: ScreenConnect (ConnectWise), Atera, AnyDesk, SimpleHelp, RemCom.
* **Tunneling**: Ligolo, Chisel, Plink (PuTTY), Ngrok, FRP (Fast Reverse Proxy).
* **Admin Tools**: `crackmapexec`, `impacket` (for lateral movement).

---

## 3. History of Engagements

### Phase 1: The "Macro" Era (2017–2020)

* **Tactic**: High-volume spear-phishing emails with "lure" documents (PDFs with links, or Word docs with Macros).
* **Exploits**: Relied heavily on social engineering rather than zero-days.
* **Goal**: Initial foothold to map networks and exfiltrate sensitive documents.

### Phase 2: Vulnerability Exploitation (2020–2022)

* **Shift**: Began targeting internet-facing vulnerabilities to bypass email filters.
* **Targets**: Exchange Server (ProxyLogon/ProxyShell), Log4j.
* **Persistence**: Immediately deploying web shells or adding users to local admin groups.

### Phase 3: Destructive Hybrid Operations (2023–Present)

* **Context**: Israel-Hamas conflict.
* **Tactic**: Rapid infiltration followed by the deployment of **BiBiWiper** to disrupt operations in Israeli tech and industrial sectors.
* **Cloud Focus**: Increased targeting of Hybrid Identity (Azure AD/Entra ID) and Exchange Online.

---

## 4. Key Tradecraft (TTPs)

| Tactic | Technique | Details |
| :--- | :--- | :--- |
| **Initial Access** | Phishing / Public Facing Application | Lure documents (often "Ministry of Foreign Affairs" themes) or exploiting N-day vulnerabilities. |
| **Execution** | PowerShell / WMI | Extensive usage of encoded PowerShell commands (`-enc`). WMI used for movement (`wmic /node:...`). |
| **Persistence** | Scheduled Tasks / RMM | Creating scheduled tasks named after Windows updates. Installing ScreenConnect agents. |
| **C2** | Web Protocols | C2 traffic often masquerades as legitimate HTTP traffic to compromised WordPress sites. |
| **Exfiltration** | Archive via Utility | RAR/7z password-protected archives uploaded to file-sharing sites (Onehub, Mega).

## 5. References

* [CISA Alert AA22-055A: Iranian Government-Sponsored Actors (MuddyWater)](https://www.cisa.gov/uscert/ncas/alerts/aa22-055a)
* [Palo Alto Unit 42: MuddyWater Profile](https://unit42.paloaltonetworks.com/tag/muddywater/)
* [MITRE ATT&CK Group G0069](https://attack.mitre.org/groups/G0069/)
