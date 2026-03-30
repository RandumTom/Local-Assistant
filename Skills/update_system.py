import subprocess
import json
import os

from main import package_manager, password

CONFIG_FILE = "config.json"
SECRETS_FILE = "secrets.json"

def load_package_manager():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as f:
            return json.load(f).get("package_manager")
    return None
    
def load_sudo_password():
    if os.path.exists(SECRETS_FILE):
        with open(SECRETS_FILE, "r") as f:
            return json.load(f).get("sudo_password")
    return None
    
def update_system():
    package_manager = load_package_manager()
    password = load_sudo_password()

    if not package_manager:
        return "No package manager configured."
    if not password:
        return "No sudo password provided."
    
    proc = subprocess.run(
        ["sudo", "-S", package_manager, "update"],
        input=password + "\n",
        capture_output=True,
        text=True,
    )

    if proc.returncode == 0:
        return "System updated successfully."
    else:
        return f"Update failed: {proc.stderr.strip()}"