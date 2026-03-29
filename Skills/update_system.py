import subprocess
import json
import os

def load_sudo_password():
    if os.path.exists("secrets.json"):
        with open("secrets.json", "r") as f:
            return json.load(f).get("sudo_password")
    return None
    
def run_sudo(command):
    password = load_sudo_password()
    if not password:
        return "No sudo password found. Please at one in the settings"
        
    proc = subprocess.run(
        ["sudo", "-S"] + command.split(),
        input=password + "\n",
        capture_output=True,
        text=True
    )
    if proc.returncode == 0:
        return "Done!"
    else:
        return f"Command failed: {proc.stderr.strip()}"