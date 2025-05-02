#!/bin/bash

# Hide cursor and restore on exit
tput civis
trap "tput cnorm; clear; exit" SIGINT

# Terminal size
width=$(tput cols)
height=$(( $(tput lines) - 1 ))
num_bars=$((width / 2))  # Each emoji takes ~2 character cells

# Frequency data
declare -a frequencies
for ((i=0; i<num_bars; i++)); do
    frequencies[$i]=0
done

# Emoji gradient from peak to trail
emoji_levels=( "🔴" "🔴" "🟠" "🟡" "🟢" "🔵" "⚫" )


generate_frequencies() {
    for ((i=0; i<num_bars; i++)); do
        fluctuation=$((RANDOM % 7 - 3))
        frequencies[$i]=$((frequencies[$i] + fluctuation))
        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

draw_equalizer() {
    tput cup 0 0
    for ((row=0; row<=height; row++)); do
        line=""
        for ((i=0; i<num_bars; i++)); do
            bar_height=${frequencies[$i]}
            draw_row=$((height - row))

            if (( bar_height > draw_row )); then
                distance=$((bar_height - draw_row))
                # Clamp distance to emoji_levels
                if (( distance >= ${#emoji_levels[@]} )); then
                    distance=$((${#emoji_levels[@]} - 1))
                fi
                emoji="${emoji_levels[$distance]}"
                line+="$emoji"
            else
                line+="  "  # Keep spacing consistent
            fi
        done
        echo -e "$line"
    done
}

# Main loop
while true; do
    generate_frequencies
    draw_equalizer
    sleep 0.1
done
