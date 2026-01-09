rule Suspicious_LNK_PowerShell_Encoded {
    meta:
        description = "Detects LNK files containing encoded PowerShell commands often used by MuddyWater"
        author = "Detection Lab"
        date = "2026-01-09"
        reference = "https://attack.mitre.org/techniques/T1059/001/"
        hash = "a1b2c3d4e5f67890abcdef1234567890abcdef1234567890abcdef1234567890"

    strings:
        $lnkmagic = { 4C 00 00 00 01 14 02 00 }
        $ps_enc   = "powershell" nocase ascii wide
        $arg_hidden = "-w hidden" nocase ascii wide
        $arg_enc    = "-enc" nocase ascii wide
        // Common Base64 chunks for "Net.WebClient" or "DownloadString" in mixed case
        $b64_webclient = "TmV0LldlYkNsaWVud" ascii // Net.WebClient
        $b64_download  = "RG93bmxvYWRTdHJpbmc" ascii // DownloadString

    condition:
        uint32(0) == 0x0000004C and
        $lnkmagic and
        $ps_enc and
        ($arg_hidden or $arg_enc) and
        1 of ($b64_*)
}
