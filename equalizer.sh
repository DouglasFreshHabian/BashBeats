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

# Function to start Basic Style
start_basic_style() {
    bash basic_style.sh
}

# Function to start Alternating Symbols Style
start_alternating_symbols_style() {
    bash alternating_symbols_style.sh
}

# Function to start Flashing Style
start_flashing_style() {
    bash flashing_style.sh
}

# Function to start Gradual Color Style
start_gradual_color_style() {
    bash gradual_color_style.sh
}

# Function to start Wave Style
start_wave_style() {
    bash wave_style.sh
}

# Print the banner in the chosen color
print_banner() {
  echo -e "${WHITEB}"
  echo -e "▄▖      ▜ ▘"
  echo -e "▙▖▛▌▌▌▀▌▐ ▌▀▌█▌▛▘"
  echo -e "▙▖▙▌▙▌█▌▐▖▌▙▖▙▖▌"
  echo -e "   ▌  "
  echo -e "${RESET}"
}

# Main menu function
main_menu() {
    clear
    echo
      for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m##\e[0m" ; done ; echo
    echo -e "${WHITEB}Select \e[5m${GREENH}Equalizer${RESET} \e[25m${WHITE}Style"
      for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m##\e[0m" ; done ; echo
    echo
    echo -e "${WHITEB}1. ${BLUE}Basic Style${RESET}"
    echo -e "${WHITEB}2. ${CYANB}Wave ${CYAN}Style"
    echo -e "${WHITEB}3. ${REDB}Flashing ${YELLOWB}Style"
    echo -e "${WHITEB}4. ${PURPLE}Gradual ${PURPLEB}Color ${PURPLEH}Style"
    echo -e "${WHITEB}5. ${YELLOWB}Alternating ${GREENB}Symbols ${REDB}Style"
    echo -e "${WHITEB}6. ${BOLDU}Exit${RESET}"
    echo
    read -p "Enter your choice [1-6]: " choice

    case $choice in
        1)
            start_basic_style
            ;;
        2)
            start_wave_style
            ;;
        3)
            start_flashing_style
            ;;
        4)
            start_gradual_color_style
            ;;
        5)
            start_alternating_symbols_style
            ;;
        6)
            echo -e "${GREENB}Goodbye${RESET}!"
            exit 0
            ;;
        *)
            echo -e "${YELLOWB}Invalid choice${RESET}, ${YELLOW}please try again${RESET}."
            sleep 2
            main_menu
            ;;
    esac
}

# Start the menu
print_banner
main_menu
