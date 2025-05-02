#!/bin/bash

# Hide cursor and ensure cleanup on exit
tput civis
trap "tput cnorm; clear; exit" SIGINT

# Set the screen size and number of bars
width=$(tput cols)
height=$(( $(tput lines) - 2 ))
num_bars=$width

# Initialize frequency bars
declare -a frequencies
for ((i = 0; i < num_bars; i++)); do
    frequencies[$i]=0
done

# Generate smooth frequency fluctuations
generate_frequencies() {
    for ((i = 0; i < num_bars; i++)); do
        fluctuation=$((RANDOM % 9 - 4))  # Range: -4 to +4
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Draw the equalizer without full-screen flicker
draw_equalizer() {
    tput cup 0 0  # Move cursor to top-left
    for ((row = height; row >= 0; row--)); do
        line=""
        for ((i = 0; i < num_bars; i++)); do
            bar_height=${frequencies[$i]}
            if (( row < bar_height )); then
                if (( bar_height <= 5 )); then
                    color="\033[38;5;46m"    # Green
                elif (( bar_height <= 10 )); then
                    color="\033[38;5;226m"   # Yellow
                elif (( bar_height <= 15 )); then
                    color="\033[38;5;196m"   # Red
                else
                    color="\033[38;5;51m"    # Cyan
                fi
                line+="$color#"
            else
                line+=" "
            fi
        done
        echo -e "$line\033[0m"  # Reset color after each line
    done
}

# Main animation loop
while true; do
    generate_frequencies
    draw_equalizer
    sleep 0.05
done
