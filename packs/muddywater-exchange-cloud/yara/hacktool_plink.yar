rule Hacktool_Plink_Tunneling {
    meta:
        description = "Detects Plink (PuTTY Link) often used for tunneling"
        author = "Detection Lab"
        date = "2026-01-09"
        reference = "https://attack.mitre.org/software/S0039/"
    strings:
        $s1 = "SSH-2.0-PuTTY_Local" ascii
        $s2 = "Local port %d forwarding to" ascii
        $s3 = "Remote port %d forwarding to" ascii
        $pe = { 4D 5A }
    condition:
        $pe at 0 and 2 of ($s*)
}
