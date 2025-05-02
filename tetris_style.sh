#!/bin/bash

# Terminal size
width=$(tput cols)
height=$(( $(tput lines) - 1 ))
num_bars=$((width / 2))

# Initialize frequency array
declare -a frequencies
for ((i=0; i<num_bars; i++)); do
    frequencies[$i]=0
done

# Trap to restore cursor on exit
trap "tput cnorm; clear; exit" SIGINT
tput civis  # Hide cursor

# Generate frequency fluctuations
generate_frequencies() {
    for ((i=0; i<num_bars; i++)); do
        fluctuation=$((RANDOM % 15 - 7))
        frequencies[$i]=$((frequencies[$i] + fluctuation))
        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Get color based on height
get_bar_color() {
    local bar_height=$1
    if (( bar_height < height / 3 )); then
        echo -e "\033[38;5;46m"   # Green
    elif (( bar_height < 2 * height / 3 )); then
        echo -e "\033[38;5;226m"  # Yellow
    else
        echo -e "\033[38;5;160m"  # Red
    fi
}

# Render equalizer bars horizontally
generate_bars() {
    for ((row=0; row<=height; row++)); do
        line=""
        for ((i=0; i<num_bars; i++)); do
            bar_height=${frequencies[$i]}
            draw_row=$((height - row))

            if (( bar_height >= draw_row )); then
                color=$(get_bar_color "$bar_height")
                line+="${color}██\033[0m"
            elif (( bar_height + 3 >= draw_row )); then
                line+="\033[38;5;240m██\033[0m"
            else
                line+="  "
            fi
        done
        echo -e "$line"
    done
}

# Main loop
while true; do
    tput cup 0 0
    generate_frequencies
    generate_bars
    sleep 0.05
done
