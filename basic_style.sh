#!/bin/bash

# Get terminal size dynamically
width=$(tput cols)
height=60   # Maximum height of the bars
num_bars=$((width / 2))  # Adjust number of bars to fit screen width

# Simulated frequency bands
declare -a frequencies
for ((i=0; i<$num_bars; i++)); do
    frequencies[$i]=0
done

# Function to simulate frequency fluctuations
generate_frequencies() {
    for ((i=0; i<$num_bars; i++)); do
        fluctuation=$((RANDOM % 12 - 6))  # Random fluctuation
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Function to generate bars with color and detail
generate_bars() {
    for ((i=0; i<$num_bars; i++)); do
        bar_height=${frequencies[$i]}
        bar_string=""

        # Random color selection based on frequency band
        rand=$((RANDOM % 100))

        if (( rand < 40 )); then
            color="\033[38;5;160m"  # Red for low frequencies
        elif (( rand < 70 )); then
            color="\033[38;5;46m"   # Green for mid frequencies
        elif (( rand < 85 )); then
            color="\033[38;5;226m"  # Yellow for higher frequencies
        elif (( rand < 95 )); then
            color="\033[38;5;51m"   # Cyan for very high frequencies
        else
            color="\033[38;5;93m"   # Purple for low-mid frequencies
        fi

        # Construct the bar
        for ((j=0; j<$bar_height; j++)); do
            bar_string+="$color#"
        done

        echo -e "$bar_string"
    done
}

# Main loop
while true; do
    clear
    generate_frequencies
    generate_bars
    sleep 0.1  # Adjust speed of equalizer
done
