import os
import sys
import yaml

def check_pack_completeness(packs_dir):
    """
    Enforces the Compounding Rule:
    Every pack directory must contain:
    1. brief.md
    2. pack.yaml
    3. At least one rule in yara, sigma, OR suricata directories.
    """
    required_files = ['brief.md', 'pack.yaml']
    detection_dirs = ['yara', 'sigma', 'suricata']
    
    violation = False

    if not os.path.exists(packs_dir):
        print(f"Error: Packs directory '{packs_dir}' not found.")
        return False

    for pack in os.listdir(packs_dir):
        pack_path = os.path.join(packs_dir, pack)
        
        # Skip non-directories or hidden files/templates
        if not os.path.isdir(pack_path) or pack.startswith('.') or pack == 'template':
            continue

        print(f"Checking Pack: {pack}...")
        
        # Check required files
        for f in required_files:
            if not os.path.exists(os.path.join(pack_path, f)):
                print(f"  [X] Missing required file: {f}")
                violation = True

        # Check for at least one detection
        has_detection = False
        for d in detection_dirs:
            d_path = os.path.join(pack_path, d)
            if os.path.exists(d_path):
                # Check if directory is not empty and has valid extension files
                files = [f for f in os.listdir(d_path) if f.endswith(('.yar', '.yml', '.yaml', '.rules'))]
                if files:
                    has_detection = True
                    break
        
        if not has_detection:
            print(f"  [X] No detection rules found in yara/, sigma/, or suricata/.")
            violation = True
            
        if not violation:
            print(f"  [+] Pack '{pack}' looks complete.")

    return not violation

if __name__ == "__main__":
    packs_path = os.path.join(os.getcwd(), 'packs')
    success = check_pack_completeness(packs_path)
    
    if success:
        print("\nAll packs pass the completeness check.")
        sys.exit(0)
    else:
        print("\nPack completeness check FAILED.")
        sys.exit(1)
