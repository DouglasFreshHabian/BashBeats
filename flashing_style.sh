#!/bin/bash

# Set the screen size and the number of bars
width=80
num_bars=$((width / 2))  # Adjust number of bars to fit screen width
height=20               # Maximum height of the bars

# Simulated frequency bands
declare -a frequencies
for ((i=0; i<$num_bars; i++)); do
    frequencies[$i]=0
done

# Function to simulate frequency fluctuations
generate_frequencies() {
    for ((i=0; i<$num_bars; i++)); do
        fluctuation=$((RANDOM % 15 - 7))  # Adjust fluctuation range
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        # Prevent bars from going below 0 or above max height
        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Function to generate flashing bars with colors
generate_flashing_bars() {
    for ((i=0; i<$num_bars; i++)); do
        bar_height=${frequencies[$i]}
        bar_string=""

        # Choose color based on bar height
        if (( bar_height == 0 )); then
            color="\033[38;5;16m"  # Black for no bars
        elif (( bar_height <= 5 )); then
            color="\033[38;5;46m"  # Green for low frequencies
        elif (( bar_height <= 10 )); then
            color="\033[38;5;226m" # Yellow for mid-low frequencies
        elif (( bar_height <= 15 )); then
            color="\033[38;5;196m" # Red for mid-high frequencies
        else
            color="\033[38;5;51m"  # Cyan for high frequencies
        fi

        # Alternate the state of the bars (full or empty)
        if (( bar_height % 2 == 0 )); then
            # When bar height is even, print the full bar
            for ((j=0; j<$bar_height; j++)); do
                bar_string+="$color#"
            done
        else
            # When bar height is odd, print an empty bar
            for ((j=0; j<$bar_height; j++)); do
                bar_string+="$color$"
            done
        fi

        # Print the bar with color
        echo -e "$bar_string"
    done
}

# Main loop
while true; do
    clear
    generate_frequencies
    generate_flashing_bars
    sleep 0.1  # Adjust speed of flashing effect
done
