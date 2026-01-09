# Threat Actor Brief: MuddyWater (BiBiWiper)

> [!CAUTION]
> **Severity**: CRITICAL | **TLP**: WHITE | **Confidence**: High

## executive summary

* **Campaign**: Sprint 3 Focus - Destructive operational phase utilizing the **BiBiWiper** family.
* **Context**: Observed targeting Israeli infrastructure and technology companies during conflict periods.
* **Key Tradecraft**:
  * **Destruction**: High-speed file overwriting (filling files with random bytes or specific strings like "BiBi").
  * **Impair Defenses**: Disabling shadow copies (`vssadmin`) and recovery mode (`bcdedit`).
  * **OS Agnostic**: Variants exist for both Windows (`BiBi-Windows`) and Linux (`BiBi-Linux`).

## attack lifecycle (mitre att&ck)

| Phase | Technique | ID | Observation |
| :--- | :--- | :--- | :--- |
| **Execution** | Command and Scripting Interpreter | T1059 | Launching Wiper binary (often manually by valid account). |
| **Defense Evasion** | Impair Defenses: Disable Recovery | T1490 | `vssadmin.exe Delete Shadows /All /Quiet` |
| **Impact** | Data Destruction | T1485 | Overwriting file content recursively. |
| **Impact** | Disk Wipe | T1561 | Corrupting MBR/MFT (in some variants). |

## telemetry requirements

1. **Endpoint**: Process Creation (for `vssadmin`, `bcdedit`).
2. **Endpoint**: File Modification events (Sysmon EID 11) showing rapid, high-volume writes by a non-system process.
3. **Endpoint**: Pipe creation or unusual handle acquisition (if using drivers).

## detection opportunities

1. **Behavioral**: A process deleting Shadow Copies (`vssadmin delete shadows`).
2. **Heuristic**: Rapid file modification renaming files to a random extension (e.g., `.BiBi`) or overwriting header bytes.
3. **Static**: YARA strings for the "BiBi" pattern or specific import hashing (Imphash).

## hunting hypothesis
>
> IF a wiper is active, THEN we will see the `vssadmin` command followed immediately by high-volume file modifications targeting user documents.

**Hypothesis**: Search for `vssadmin.exe` with command line `delete shadows` AND `quiet`.
