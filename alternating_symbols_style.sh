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

# Function to generate bars with alternating symbols and color
generate_bars() {
    for ((i=0; i<$num_bars; i++)); do
        bar_height=${frequencies[$i]}
        bar_string=""

        # Random color selection based on frequency band
        rand=$((RANDOM % 100))

        if (( rand < 40 )); then
            color="\033[38;5;160m"  # Red for low frequencies
            symbol="*"
        elif (( rand < 70 )); then
            color="\033[38;5;46m"   # Green for mid frequencies
            symbol="+"
        elif (( rand < 85 )); then
            color="\033[38;5;226m"  # Yellow for higher frequencies
            symbol="%"
        elif (( rand < 95 )); then
            color="\033[38;5;51m"   # Cyan for very high frequencies
            symbol="&"
        else
            color="\033[38;5;93m"   # Purple for low-mid frequencies
            symbol="@"
        fi

        # Construct the bar with alternating symbols
        for ((j=0; j<$bar_height; j++)); do
            if ((j % 2 == 0)); then
                bar_string+="$color$symbol"
            else
                bar_string+="$color$symbol"
            fi
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
