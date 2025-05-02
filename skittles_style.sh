#!/bin/bash

# Get terminal size dynamically
width=$(tput cols)
height=$(( $(tput lines) - 5 ))  # Maximum height of the bars based on the terminal's height
num_bars=$((width))  # Set number of bars to fit the width of the terminal

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

# Function to generate horizontal bars with color and detail
generate_bars() {
    for ((row=height; row>=0; row--)); do  # Iterate from the top of the terminal to bottom
        line=""
        for ((i=0; i<$num_bars; i++)); do
            bar_height=${frequencies[$i]}

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
            if (( row < bar_height )); then
                line+="$color#"
            else
                line+=" "
            fi
        done
        echo -e "$line"
    done
}

# Main loop
while true; do
    clear  # Clear terminal screen
    generate_frequencies
    generate_bars
    sleep 0.1  # Adjust speed of equalizer
done
