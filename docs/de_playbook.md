# Detection Engineering Playbook

## 1. The "Intel-to-Detection" Cycle

All detection logic in this lab follows this lifecycle:

1. **Intel Trigger**: A new Threat Actor Brief (OSINT) triggers a requirement.
2. **Lab Replication**: We replicate the techique in a safe VM to generate telemetry.
3. **Drafting**: Rules are written in Sigma (Logs) and YARA (Files).
4. **Validation**: A test script (Atomic Red Team style) MUST verify the rule fires.

## 2. Rule Quality Bar

| Rule Type | Acceptance Criteria |
| :--- | :--- |
| **YARA** | Must match the specific sample AND generic family traits. Must NOT fire on `C:\Windows\System32\*` clean set. |
| **Sigma** | Must cover the specific command line flags observed. Should use `selection_img` AND `selection_cli`. |
| **Suricata** | Must target the specific C2 protocol anomaly (e.g., UA string + URI pattern). |

## 3. Maintenance ("The Compounding Rule")

* Every Pack MUST have meaningful content in YARA, Sigma, and Suricata folders (unless technically not applicable, e.g., fileless lateral movement has no YARA).
* CI/CD `check_completeness.py` enforces this.
