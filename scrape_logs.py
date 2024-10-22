import os
import time
from smb.SMBConnection import SMBConnection

# Configuration
smb_server = "samwise.dsb.dk"
smb_share = "app1"
log_file_name = "utmping.log"

smb_file_path = "rosa-appl-1/rosa/log/"+log_file_name
poll_interval = 60  # Poll every 60 seconds

# SMB Connection Configuration
smb_user = ""  # Guest access
smb_password = ""  # Guest access
smb_client_machine_name = "client_machine"
smb_server_name = "samwise.dsb.dk"

# Establish SMB connection
conn = SMBConnection(smb_user, smb_password, smb_client_machine_name, smb_server_name, use_ntlm_v2=True)
assert conn.connect(smb_server, 139)

def get_file_info():
    try:
        files = conn.listPath(smb_share, os.path.dirname(smb_file_path), pattern=log_file_name)
        for file in files:
            if file.filename == os.path.basename(smb_file_path):
                return file.create_time
    except Exception as e:
        print(f"Error fetching file info: {e}")
    return None

def fetch_file():
    try:
        with open(log_file_name, 'wb') as file_obj:
            conn.retrieveFile(smb_share, smb_file_path, file_obj)
        print(f"File fetched successfully: {log_file_name} from {smb_file_path}.")
    except Exception as e:
        print(f"Error fetching file: {e}")

def main():
    last_info = None
    while True:
        current_info = get_file_info()
        if current_info != last_info:
            print(f"File info changed: {current_info}")
            fetch_file()
            last_info = current_info
        time.sleep(poll_interval)

if __name__ == "__main__":
    main()