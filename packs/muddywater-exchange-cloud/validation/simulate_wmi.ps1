<#
.SYNOPSIS
    Simulates WMI Lateral Movement behavior (Local Simulation).
    
.DESCRIPTION
    Executes a process via WMI locally to trigger the "WmiPrvSE -> cmd.exe" lineage.
    Note: For true lateral movement, this would target a remote host, but local WMI spawns trigger the same parent-child relationship in Sysmon.
#>

Write-Host "[*] Simulating WMI Process Execution..." -ForegroundColor Cyan

# Use WMI to spawn a benign process (cmd.exe /c echo)
# This will appear as WmiPrvSE.exe -> cmd.exe
$Process = Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList "cmd.exe /c echo 'WMI-Simulation-Success' > C:\Temp\wmi_test.txt"

if ($Process.ReturnValue -eq 0) {
    Write-Host "[+] WMI Method Invoked Successfully."
    Write-Host "    Check Sysmon EID 1 (ParentImage: WmiPrvSE.exe)"
}
else {
    Write-Host "[-] WMI Invocation Failed. ReturnCode: $($Process.ReturnValue)"
}
