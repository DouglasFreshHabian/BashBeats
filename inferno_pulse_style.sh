#!/bin/bash

# Define color escape codes

# Regular Colors
RED='\033[0;31m'       # Red
GREEN='\033[0;32m'     # Green
YELLOW='\033[0;33m'    # Yellow
BLUE='\033[0;34m'      # Blue
CYAN='\033[0;36m'      # Cyan
PURPLE='\033[0;35m'    # Purple
WHITE='\033[0;37m'     # White
RESET='\033[0m'        # Reset

# Bold Colors
REDB='\033[1;31m'      # Red
GREENB='\033[1;32m'    # Green
YELLOWB='\033[1;33m'   # Yellow
BLUEB='\033[1;34m'     # Blue
CYANB='\033[1;36m'     # Cyan
PURPLEB='\033[1;35m'   # Purple
WHITEB='\033[1;37m'    # White

# Bold High Intensity
BLACKH='\e[1;90m'      # Black
REDH='\e[1;91m'        # Red
GREENH='\e[1;92m'      # Green
YELLOWH='\e[1;93m'     # Yellow
BLUEH='\e[1;94m'       # Blue
PURPLEH='\e[1;95m'     # Purple
CYANH='\e[1;96m'       # Cyan
WHITEH='\e[1;97m'      # White

# Set the screen size and number of bars
width=$(tput cols)
height=$(( $(tput lines) - 8 ))  # Dynamic height: full terminal minus header and controls
num_bars=$((width))  # Use full terminal width

# Simulated frequency bands
declare -a frequencies
for ((i=0; i<$num_bars; i++)); do
    frequencies[$i]=0
done

# Function to simulate frequency fluctuations
generate_frequencies() {
    for ((i=0; i<$num_bars; i++)); do
        fluctuation=$((RANDOM % 15 - 7))
        frequencies[$i]=$((frequencies[$i] + fluctuation))

        if ((frequencies[$i] < 0)); then
            frequencies[$i]=0
        elif ((frequencies[$i] > height)); then
            frequencies[$i]=$height
        fi
    done
}

# Function to draw the horizontal equalizer
draw_equalizer() {
    for ((row=height; row>=0; row--)); do
        line=""
        for ((i=0; i<$num_bars; i++)); do
            bar_height=${frequencies[$i]}

            if (( row < bar_height )); then
                if (( bar_height == 0 )); then
                    color="\033[38;5;16m"
                elif (( bar_height <= 5 )); then
                    color="\033[38;5;46m"
                elif (( bar_height <= 10 )); then
                    color="\033[38;5;226m"
                elif (( bar_height <= 15 )); then
                    color="\033[38;5;196m"
                else
                    # Cyan bars now limited to slightly above 15, not full height
                    bar_height=$((height / 2 + RANDOM % (height / 4)))
                    color="\033[38;5;51m"
                fi

                if (( bar_height % 2 == 0 )); then
                    line+="$color#"
                else
                    line+="$color$"
                fi
            else
                line+=" "
            fi
        done
        echo -e "$line"
    done
}

# Function to animate control knobs
animate_controls() {
    frame=$((frame + 1))
    knob1=$(( (frame / 2) % 4 ))
    knob2=$(( (frame / 3 + 2) % 4 ))
    knob3=$(( (frame / 4 + 3) % 4 ))

    positions=("${REDB}|${RESET}" "${YELLOWB}/${RESET}" "${BLUEB}-${RESET}" "\\")
    echo -ne "\033[0m"

    echo -e "${GREENB}Controls${RESET}:"
    echo -e "  ${BLUEB}Volume${RESET}:   [${positions[$knob1]}]"
    echo -e "  ${YELLOWB}Treble${RESET}:   [${positions[$knob2]}]"
    echo -e "  ${REDB}Bass${RESET}:     [${positions[$knob3]}]"
    echo ""
}

# Main loop
frame=0
while true; do
    tput cup 0 0
    echo -e "\033[1mInferno Pulse\033[0m"
    echo ""
    generate_frequencies
    draw_equalizer
    animate_controls
    sleep 0.1
done
