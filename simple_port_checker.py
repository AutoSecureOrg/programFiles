import sys
import socket
import time

def check_port(ip, port, timeout=1):
    """Attempts to connect to a specific IP and port."""
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(timeout)
            s.connect((ip, port))
            return True # Connection successful
    except (socket.timeout, ConnectionRefusedError, OSError):
        return False # Connection failed or refused
    except Exception as e:
        print(f"[!] Unexpected error connecting to {ip}:{port} -> {e}", file=sys.stderr)
        return False

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python simple_port_checker.py <target_ip>", file=sys.stderr)
        sys.exit(1)

    target_ip = sys.argv[1]
    common_ports = [21, 22, 80, 443, 3389, 8080] # FTP, SSH, HTTP, HTTPS, RDP, HTTP-Alt

    print(f"--- Starting Simple Port Check for {target_ip} ---")
    # Example of writing to stderr
    print(f"DEBUG: Script received target {target_ip}", file=sys.stderr)

    found_open = False
    for port in common_ports:
        print(f"Checking port {port}...", end="")
        if check_port(target_ip, port):
            print(f" OPEN")
            found_open = True
        else:
            print(f" CLOSED/FILTERED")
        time.sleep(0.1) # Small delay

    if found_open:
         print(f"--- Found at least one open common port on {target_ip} ---")
    else:
         print(f"--- No common ports seem open on {target_ip} ---")

    # Example: Exit with code 0 (success) regardless of open ports
    # If you wanted to indicate failure, you could sys.exit(1) based on a condition.
    sys.exit(0)
