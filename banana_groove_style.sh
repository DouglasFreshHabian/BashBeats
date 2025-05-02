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

# Extra...
BOLDU='\e[1;4m'        # Bold + Underlined

# Terminal dimensions
width=$(tput cols)
term_height=$(tput lines)
height=20  # Equalizer bar height
num_bars=$((width / 2))
bottom_offset=$((term_height - height - 5))  # 5 rows for controls/pulse

# Frequency data
declare -a frequencies
for ((i=0; i<num_bars; i++)); do
    frequencies[$i]=0
done

# Cursor trap
trap "tput cnorm; clear; exit" SIGINT
tput civis

# Simulated BPM
bpm=$((60 + RANDOM % 80))
frame_count=0

# Frequency generator
generate_frequencies() {
    for ((i=0; i<num_bars; i++)); do
        fluctuation=$((RANDOM % 15 - 7))
        frequencies[$i]=$((frequencies[$i] + fluctuation))
        ((frequencies[$i] < 0)) && frequencies[$i]=0
        ((frequencies[$i] > height)) && frequencies[$i]=$height
    done
}

# Bar color mapper
get_bar_color() {
    local bar_height=$1
    if (( bar_height < height / 3 )); then
        echo -e "\033[38;5;46m"
    elif (( bar_height < 2 * height / 3 )); then
        echo -e "\033[38;5;226m"
    else
        echo -e "\033[38;5;160m"
    fi
}

generate_bars() {
    for ((i=0; i<num_bars; i++)); do
        bar_height=${frequencies[$i]}
        for ((row=0; row<height; row++)); do
            target_row=$((bottom_offset + height - row))
            tput cup $target_row $((i * 2))
            if (( bar_height > row )); then
                color=$(get_bar_color $bar_height)
                echo -ne "${color}██\033[0m"
            elif (( bar_height + 3 > row )); then
                echo -ne "\033[38;5;240m██\033[0m"
            else
                echo -ne "  "
            fi
        done
    done
}

# BPM overlay
draw_bpm() {
    tput cup 0 $((width - 12))
    echo -ne "\033[1;36mBPM: $bpm\033[0m"
}

# Pulse beat
draw_pulse() {
    local col=$(( (width / 2) - 2 ))
    tput cup $((bottom_offset + height + 1)) $col
    echo -ne "\033[1;31m⏯   ⏹   ⏮   ⏭   ⏪  ⏩\033[0m"
}

clear_pulse() {
    local col=$(( (width / 2) - 2 ))
    tput cup $((bottom_offset + height + 1)) $col
    echo -ne "   "
}

# ASCII Control Panel
draw_controls() {
    local control_row=$((bottom_offset + height + 2))

    # Oscillate positions (cycle every ~40 frames)
    local knob_pos=$(( (frame_count / 4) % 6 ))
    local treble_pos=$(( (frame_count / 6 + 3) % 6 ))
    local vol_pos=$(( (frame_count / 5 + 1) % 6 ))

    # Function to generate slider with moving ◉
    draw_slider() {
        local pos=$1
        local slider=""
        for ((i=0; i<6; i++)); do
            if (( i == pos )); then
                slider+="◉"
            else
                slider+="─"
            fi
        done
        echo "$slider"
    }

    local bass_slider=$(draw_slider $knob_pos)
    local treb_slider=$(draw_slider $treble_pos)
    local vol_slider=$(draw_slider $vol_pos)

    # Draw sliders
    tput cup $control_row 0
    echo -e "[ ${BLUEB}BASS${RESET} ] ${WHITEB}$bass_slider${RESET}   [ ${PURPLEB}TREB${RESET} ] $treb_slider   [ ${GREENB}VOL${RESET} ] $vol_slider\033[0m"

    # Mode buttons
    tput cup $((control_row + 1)) 0
    echo -e "[ ${GREENH}MODE${RESET} ] [\e[5m${CYANH}Wave${RESET}] [\e[5m${YELLOWH}Flashing${RESET}] [\e[5m${REDB}Inferno${RESET}]\033[0m [ ${WHITEB}STAY FRESH${RESET} ]"
}

# Main loop
while true; do
    tput cup 0 0
    generate_frequencies
    generate_bars
    draw_bpm

    # Pulse rhythm
    if (( frame_count % 20 == 0 )); then
        draw_pulse
    else
        clear_pulse
    fi

    # Redraw controls every frame
    draw_controls

    # Refresh BPM every ~10 seconds
    if (( frame_count % 200 == 0 )); then
        bpm=$((60 + RANDOM % 80))
    fi

    ((frame_count++))
    sleep 0.05
done
