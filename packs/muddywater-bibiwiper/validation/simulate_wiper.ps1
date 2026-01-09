<#
.SYNOPSIS
    Simulates BiBiWiper behavior SAFELY.
    
.DESCRIPTION
    1. Simulates vssadmin usage (Process Creation).
    2. Creates a dummy file and renames it with .BiBi extension (File Modification).
    
    SAFETY: Does NOT actually delete shadow copies (uses echo). Does NOT overwrite critical files.
#>

$TestDir = "C:\Temp\DetectionLab_Tests\WiperCheck"
if (-not (Test-Path $TestDir)) { New-Item -Path $TestDir -ItemType Directory -Force | Out-Null }

Write-Host "[*] Starting Safe Wiper Simulation..." -ForegroundColor Cyan

# 1. Simulate VSSAdmin (triggers Sigma/Sysmon)
# We use cmd /c to mimic the command line without executing the destructive tool
Write-Host "[*] Simulating Shadow Copy Deletion Command..."
Start-Process cmd.exe -ArgumentList "/c vssadmin.exe delete shadows /all /quiet" -Wait

# 2. Simulate File renaming (BiBi extension)
Write-Host "[*] Simulating File Renaming (.BiBi)..."
$DummyFile = "$TestDir\important_document.docx"
$WipedFile = "$TestDir\important_document.docx.BiBi"

"This is a test document" | Out-File $DummyFile
Rename-Item -Path $DummyFile -NewName "important_document.docx.BiBi" -Force

if (Test-Path $WipedFile) {
    Write-Host "[+] File Renamed Successfully to .BiBi"
    Write-Host "    Check Sysmon EID 11 (FileCreate/Rename)"
}

Write-Host "[+] Simulation Complete."
