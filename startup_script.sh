#!/bin/bash

# Wait for Wi-Fi to connect
while ! ping -c 1 -W 1 google.com > /dev/null 2>&1; do
    echo "Waiting for Wi-Fi connection..."
    sleep 5
done

echo "Wi-Fi connected."

# Define only the virtual environment path
VENV_PATH="/home/autosecure/FYP/web-dashboard/venv"

# Run the Flask backend (this one still needs to cd into the project)
x-terminal-emulator -e "bash -c 'cd /home/autosecure/FYP/web-dashboard && source $VENV_PATH/bin/activate && python3 app.py; exec bash'" &

# Launch Metasploit (no venv needed)
x-terminal-emulator -e "bash -c 'msfconsole -q -x \"load msgrpc ServerHost=127.0.0.1 ServerPort=55552 Pass=your_password\"; exec bash'" &

# Run AI Server (no need to cd if it’s standalone)
x-terminal-emulator -e "bash -c 'source $VENV_PATH/bin/activate && python3 /home/autosecure/FYP/startup/ai_server.py; exec bash'" &
