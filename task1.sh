#!/bin/bash

# Finding the process ID 
pid=$(ps aux | grep '[i]nfinite.sh' | awk '{print $2}')

# Checking if found and then terminating it
if [ -n "$pid" ]; then
    kill "$pid"
    echo "Killed process with PID: $pid"
else
    echo "No infinite.sh process found."
fi
