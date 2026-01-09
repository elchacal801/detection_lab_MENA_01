<#
.SYNOPSIS
    Simulates MuddyWater PowerTon behavior for detection validation.
    SAFE: Does not download actual malware. Uses local echo and safe domains.

.DESCRIPTION
    1. Creates a dummy LNK file with suspicious arguments.
    2. Executes a PowerShell download attempt to a dummy domain (triggers Network/Process signatures).
#>

$SimulationID = "MW-SIM-001"
$TestDir = "C:\Temp\DetectionLab_Tests\$SimulationID"
if (-not (Test-Path $TestDir)) { New-Item -Path $TestDir -ItemType Directory -Force | Out-Null }

Write-Host "[*] Starting MuddyWater Simulation ($SimulationID)..." -ForegroundColor Cyan

# 1. Create Suspicious LNK File (Triggers YARA)
$LnkPath = "$TestDir\Invoice_Details.doc.lnk"
$WScript = New-Object -ComObject WScript.Shell
$Shortcut = $WScript.CreateShortcut($LnkPath)
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-nop -w hidden -enc TmV0LldlYkNsaWVudAA=" # Base64 for Net.WebClient
$Shortcut.WindowStyle = 7 # Minimized
$Shortcut.Save()
Write-Host "[+] Created Suspicious LNK: $LnkPath"

# 2. Simulate Process Execution & Network Call (Triggers Sigma & Suricata)
Write-Host "[*] Simulating Process and Network request..."
Start-Process powershell.exe -ArgumentList "-nop -w hidden -Command `"Write-Host 'Simulating C2'; Invoke-WebRequest -Uri 'http://example.com/admin.php' -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Microsoft WindowsPowerShell/v1.0)'`"" -Wait

Write-Host "[+] Simulation Complete. Check EDR and Network Logs." -ForegroundColor Green
Write-Host "    - YARA should detect: $LnkPath"
Write-Host "    - Sigma should detect: powershell.exe starting with -w hidden"
Write-Host "    - Suricata should detect: HTTP GET to /admin.php with PowerShell UA (if not spoofed)"
