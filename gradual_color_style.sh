#!/bin/bash

# Get terminal size dynamically
width=$(tput cols)
height=80   # Maximum height of the bars
num_bars=$((width / 2))  # Adjust number of bars to fit screen width

# Simulated frequency bands
declare -a frequencies
for ((i=0; i<$num_bars; i++)); do
    frequencies[$i]=0
done

# Function to simulate frequency fluctuations (increase fluctuation range)
generate_frequencies() {
    for ((i=0; i<$num_bars; i++)); do
        fluctuation=$((RANDOM % 15 - 7))  # Increased fluctuation range
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        # Prevent bars from going below 0 or above max height
        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Function to map height to color gradient (green -> yellow -> red)
get_bar_color() {
    local bar_height=$1
    local color

    if (( bar_height < height / 3 )); then
        # Green for low bars
        color="\033[38;5;46m"
    elif (( bar_height < 2 * height / 3 )); then
        # Yellow for medium bars
        color="\033[38;5;226m"
    else
        # Red for high bars
        color="\033[38;5;160m"
    fi

    echo $color
}

# Function to generate bars with gradual color change
generate_bars() {
    for ((i=0; i<$num_bars; i++)); do
        bar_height=${frequencies[$i]}
        bar_string=""

        # Get color based on height
        color=$(get_bar_color $bar_height)

        # Create the bar
        for ((j=0; j<$bar_height; j++)); do
            bar_string+="$color#"
        done

        # Print the bar
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
