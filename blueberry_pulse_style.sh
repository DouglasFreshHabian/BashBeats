#!/bin/bash

# Get terminal dimensions
width=$(tput cols)
height=$(( $(tput lines) - 2 ))
num_bars=$((width / 2))  # 2 spaces per bar

# Symbol and color setup
symbols=( '@' '#' '*' '+' '%' '&' '∞' 'µ' )
colors=(160 202 190 82 46 51 39 33 93 129 201 165)
num_colors=${#colors[@]}

# Bar data
declare -a frequencies
declare -a trail
for ((i=0; i<$num_bars; i++)); do
    frequencies[$i]=$((RANDOM % height))
    trail[$i]=0
done

# Update frequencies to simulate motion
generate_frequencies() {
    timestamp_fragment=$(date +%s%N | cut -b10-12 | sed 's/^0*//')
    for ((i=0; i<$num_bars; i++)); do
        trail[$i]=${frequencies[$i]}
        wave=$(( (i + timestamp_fragment) % 20 ))
        fluctuation=$(( (RANDOM % 7 - 3) + wave / 4 ))
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        # Clamp values
        ((frequencies[$i] < 0)) && frequencies[$i]=0
        ((frequencies[$i] > height)) && frequencies[$i]=$((height / 4 + RANDOM % (height / 2)))

    done
}

# Draw the horizontal equalizer with vertical bars
draw_equalizer() {
    tput cup 0 0
    for ((row=0; row<=height; row++)); do
        line=""
        for ((i=0; i<$num_bars; i++)); do
            bar_height=${frequencies[$i]}
            color_index=$(( (i + row + RANDOM % 3) % num_colors ))
            color_code=${colors[$color_index]}

	if (( height - row == bar_height )); then
	    # PEAK DOT
	    line+="\033[38;5;15m• "  # white dot as peak
	elif (( height - row < bar_height )); then
	    symbol=${symbols[$RANDOM % ${#symbols[@]}]}
	    line+="\033[38;5;${color_code}m$symbol "   
            else
                line+="  "
            fi
        done
        echo -e "$line"
    done
}

# Main loop
while true; do
    generate_frequencies
    draw_equalizer
    sleep 0.08
    echo -ne "\033[0m"
done
