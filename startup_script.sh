#!/bin/bash

# Wait for Wi-Fi to connect
while ! ping -c 1 -W 1 google.com > /dev/null 2>&1; do
    echo "Waiting for Wi-Fi connection..."
    sleep 5
done

echo "Wi-Fi connected."

# Run the email script and then start the Flask backend in the same terminal
x-terminal-emulator -e "bash -c 'python3 /home/autosecure/FYP/startup/ip_email.py; cd FYP/web-dashboard && source venv/bin/activate && python3 app.py; exec bash'" &

# Launch Metasploit in another terminal and keep it running
x-terminal-emulator -e "bash -c 'msfconsole -q -x \"load msgrpc ServerHost=127.0.0.1 ServerPort=55552 Pass=your_password\"; exec bash'" &
