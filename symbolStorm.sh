#!/bin/bash

# Hide cursor and handle exit
tput civis
trap "tput cnorm; clear; exit" SIGINT

# Get terminal size dynamically
width=$(tput cols)
height=$(( $(tput lines) - 2 ))
num_bars=$width

# Simulated frequency bands
declare -a frequencies
for ((i=0; i<$num_bars; i++)); do
    frequencies[$i]=0
done

# Simulate frequency fluctuations
generate_frequencies() {
    for ((i=0; i<$num_bars; i++)); do
        fluctuation=$((RANDOM % 12 - 6))
        frequencies[$i]=$((frequencies[$i] + fluctuation))
        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Draw bars with symbols and color
generate_bars() {
    tput cup 0 0
    for ((row=height; row>=0; row--)); do
        line=""
        for ((i=0; i<$num_bars; i++)); do
            bar_height=${frequencies[$i]}
            if (( row < bar_height )); then
                rand=$((RANDOM % 100))
                if (( rand < 40 )); then
                    color="\033[38;5;160m"; symbol="*"
                elif (( rand < 70 )); then
                    color="\033[38;5;46m";  symbol="+"
                elif (( rand < 85 )); then
                    color="\033[38;5;226m"; symbol="%"
                elif (( rand < 95 )); then
                    color="\033[38;5;51m";  symbol="&"
                else
                    color="\033[38;5;93m";  symbol="@"
                fi
                line+="$color$symbol"
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
    generate_bars
    sleep 0.1
done
