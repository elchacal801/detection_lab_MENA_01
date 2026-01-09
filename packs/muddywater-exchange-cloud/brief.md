# Threat Actor Brief: MuddyWater (Hybrid Exchange Focus)

> [!CAUTION]
> **Severity**: HIGH | **TLP**: WHITE | **Confidence**: High

## executive summary

* **Campaign**: Sprint 2 Focus - Post-Compromise Lateral Movement & Cloud Persistence.
* **Context**: After initial access (LNK/PowerShell), MuddyWater shifts to lateral movement using WMI/WinRM and targets Exchange Online (O365) for long-term persistence.
* **Key Tradecraft**:
  * **Lateral Movement**: Remote WMI execution using `wmic` or PowerShell `Invoke-WmiMethod`.
  * **Cloud Persistence**: Creation of Outlook "Inbox Rules" to forward high-value emails to external accounts (Exfiltration) or to move C2 emails to hidden folders (Defense Evasion).
  * **Tunneling**: Usage of `Ligolo` or `Plink` to tunnel RDP/SMB traffic out.

## attack lifecycle (mitre att&ck)

| Phase | Technique | ID | Observation |
| :--- | :--- | :--- | :--- |
| **Lateral Movement** | Windows Management Instrumentation | T1047 | `wmic /node:SERVER process call create "powershell..."` |
| **Persistence** | Office Application Startup: Office Template Macros | T1137.001 | Modifying `Normal.dotm` for persistence. |
| **Defense Evasion** | Email Collection: Email Forwarding Rule | T1114.003 | Creating client-side or server-side (O365) rules to forward mail. |
| **Command and Control** | Proxy | T1090 | Using `Ligolo-ng` to tunnel traffic from internal segments. |

## telemetry requirements

1. **Identity (Azure AD)**: `UnifiedAuditLog` focusing on `New-InboxRule` or `Set-InboxRule` operations.
2. **Endpoint**: Process Creation with command line `wmic` containing `/node:` or `process call create`.
3. **Network**: Long-duration TCP connections to non-standard ports (Tunneling).

## detection opportunities

1. **Cloud**: New Inbox Rule created forwarding email to external domain (High Fidelity).
2. **Endpoint**: `wmic` spawning `powershell` or `cmd` on a remote host.
3. **Behavioral**: `svchost.exe` (hosting WmiPrvSE) spawning unexpected shells.

## hunting hypothesis
>
> IF the actor moves laterally, THEN we will see WMI process creation events on destination servers originating from the foothold machine.

**Hypothesis**: Search for `WmiPrvSE.exe` spawning `cmd.exe` or `powershell.exe`. This is the hallmark of WMI execution on the *target* machine.
