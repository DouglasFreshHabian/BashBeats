#!/bin/bash

# Hide cursor and reset on exit
tput civis
trap "tput cnorm; clear; exit" SIGINT

# Terminal size
width=$(tput cols)
height=$(( $(tput lines) - 1 ))  # Use almost full height
num_bars=$((width))

# Simulated frequency bands
declare -a frequencies
for ((i=0; i<num_bars; i++)); do
    frequencies[$i]=0
done

# Simulate frequency fluctuations
generate_frequencies() {
    for ((i=0; i<num_bars; i++)); do
        fluctuation=$((RANDOM % 9 - 4))
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Draw the horizontal equalizer
draw_equalizer() {
    tput cup 0 0
    for ((row=0; row<=height; row++)); do
        line=""
        for ((i=0; i<num_bars; i++)); do
            bar_height=${frequencies[$i]}
            draw_row=$((height - row))

            if (( bar_height > draw_row )); then
                distance=$((bar_height - draw_row))
                if (( distance == 0 )); then
                    color="\033[38;5;15m"   # Bright white peak
                elif (( distance <= 2 )); then
                    color="\033[38;5;250m"  # Light gray
                elif (( distance <= 4 )); then
                    color="\033[38;5;245m"  # Medium gray
                else
                    color="\033[38;5;240m"  # Faded tail
                fi
                line+="$color#"
            else
                line+=" "
            fi
        done
        echo -e "$line\033[0m"
    done
}

# Main loop
while true; do
    generate_frequencies
    draw_equalizer
    sleep 0.1
done
