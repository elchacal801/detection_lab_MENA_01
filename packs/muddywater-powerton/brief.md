# Threat Actor Brief: MuddyWater (PowerTon Campaign)

> [!CAUTION]
> **Severity**: HIGH | **TLP**: WHITE | **Confidence**: High

## executive summary

* **Actor**: MuddyWater (aka MERCURY, Static Kitten, Seedworm). Linked to Iran's MOIS.
* **Objective**: Espionage, Intellectual Property Theft, and Destructive Attacks (Wipers) targeting Middle East adversaries and Western telecommunications/energy/finance sectors.
* **Campaign Focus**: "PowerTon" - Utilization of macro-laden documents to deploy PowerShell backdoors for initial access and persistence.
* **Relevance to F500**: High risk for entities with branches in Israel, Turkey, UAE, or Saudi Arabia, or those in the energy/defense supply chain.
* **Key Tradecraft**: "Living off the Land" (LotL) - Heavy reliance on PowerShell, WMI, and legitimate remote admin tools (ScreenConnect, e.g.) to evade signature-based detection.

## attack lifecycle (mitre att&ck)

| Phase | Technique | ID | Observation |
| :--- | :--- | :--- | :--- |
| **Initial Access** | Phishing: Spearphishing Attachment | T1566.001 | PDF URLs or Excel Macros delivering generic LNK/Script loaders. |
| **Execution** | Command and Scripting Interpreter: PowerShell | T1059.001 | Obfuscated PS1 scripts (PowerTon/PowerStats). |
| **Persistence** | Scheduled Task / Job | T1053.005 | Registry keys or Tasks to run C2 scripts on boot. |
| **C2** | Web Protocols | T1071.001 | Beacons over HTTP/S to compromised WordPress sites. |
| **Exfiltration** | Archive Collected Data | T1560 | Using `WinRAR` or `7z` to compress data before egress. |

## telemetry requirements

To detect this campaign, the following logs are critical:

1. **Endpoint**: Process Creation (EID 4688) with Command Line - *Critical* for spotting encoded PowerShell.
2. **Network**: Proxy/Firewall logs - To detect C2 beacons to unusual TLDs or compromised CMS sites.
3. **Active Directory**: 4624/4625 Login events - To detect lateral movement if initial access succeeds.

## detection opportunities

1. **High Fidelity**: PowerShell process spawned by `WINWORD.EXE` or `EXCEL.EXE`.
2. **High Fidelity**: `certutil.exe` or `bitsadmin.exe` downloading files (ingress tool transfer).
3. **Medium Fidelity**: Network connections to uncategorized domains/IPs initiated by `powershell.exe`.

## hunting hypothesis
>
> IF MuddyWater has established a foothold, THEN we will observe abnormal PowerShell child processes executing network connections or creating scheduled tasks.

**Hypothesis**: Search for `powershell.exe` execution where the command line contains `DownloadString`, `IEX`, or `Invoke-Expression` AND the parent process is NOT an administrative tool (e.g., is `explorer.exe` or `svchost.exe`).
