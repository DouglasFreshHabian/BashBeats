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

# Function to start Symbols Style
start_symbols_style() {
    bash symbols.sh
}

# Function to start SymbolStorm Style
start_symbolStorm_style() {
    bash symbolStorm.sh
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

# Function to start Inferno Pulse Style
start_inferno_pulse_style() {
    bash inferno_pulse_style.sh
}

# Function to start Blueberry Pulse Style
start_blueberry_pulse_style() {
    bash blueberry_pulse_style.sh
}

# Function to start Tetris Style
start_tetris_style() {
    bash tetris_style.sh
}

# Function to start wFlicker Style
start_flicker_style() {
    bash flicker_style.sh
}

# Function to start BananaGroove Style
start_banana_groove_style() {
    bash banana_groove_style.sh
}

# Function to start Gray Style
start_gray_style() {
    bash gray_style.sh
}

# Function to start Gray Style
start_emojiwave_style() {
    bash emojiwave_style.sh
}

# Function to start Emoji Heart Style
start_emojiheart_style() {
    bash emojiheart_style.sh
}

# Function to start Lunoji Style
start_lunoji_style() {
    bash lunoji_style.sh
}

# Function to start cosmiQ Style
start_cosmiq_style() {
    bash cosmiq_style.sh
}

# Function to start TokyoTuner Style
start_tokyotuner_style() {
    bash tokyoTuner.sh
}

# Function to start VolumeVibes Style
start_volumeVibes_style() {
    bash volumeVibes.sh
}

# Function to start diskBeats Style
start_diskBeats_style() {
    bash diskBeats.sh
}

# Function to print Ascii QR-Code to Screen
print_qr_code() {
    echo "https://www.youtube.com/@DouglasHabian-tq5ck" | qr --ascii
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
    echo -e "${WHITEB}Select \e[5m${YELLOWH}E${BLUEB}q${REDH}u${CYANB}a${GREENH}l${PURPLEB}i${REDB}z${BLUEH}e${YELLOWB}r${RESET} \e[25m${WHITE}Style"
      for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m##\e[0m" ; done ; echo
    echo
    echo -e "${WHITEB}1.  ${BLUEB}Basic ${WHITEB}"
    echo -e "${WHITEB}2.  ${CYANB}Wave ${WHITEB}"
    echo -e "${WHITEB}3.  ${REDB}Fl${YELLOWB}ash${REDB}ing ${WHITEB}"
    echo -e "${WHITEB}4.  ${PURPLE}Gra${PURPLEB}du${PURPLEH}al ${WHITEB}"
    echo -e "${WHITEB}5.  ${YELLOWB}S${GREENB}y${REDB}m${YELLOWB}b${GREENB}o${REDB}l${YELLOWB}s ${WHITEB}"
    echo -e "${WHITEB}6.  ${PURPLEB}Blueberry${PURPLEH}Pulse ${WHITEB}"
    echo -e "${WHITEB}7.  ${YELLOWB}Banana${YELLOWH}Groove ${WHITEB}"
    echo -e "${WHITEB}8.  ${REDB}Inferno${REDH}Pulse ${WHITEB}"
    echo -e "${WHITEB}9.  ${YELLOWB}S${GREENB}y${REDB}m${YELLOWB}b${GREENB}o${REDB}l${YELLOWB}Storm ${WHITEB}"
    echo -e "${WHITEB}10. ${GREENB}T${GREENH}e${GREENB}tr${BLUEB}i${GREENB}s ${WHITEB}"
    echo -e "${WHITEB}11. ${YELLOWH}Fl${YELLOW}i${YELLOWH}cker ${WHITEB}"
    echo -e "${WHITEB}12. ${BLACKH}Gray${RESET}"
    echo -e "${WHITEB}13. ${GREENH}Emoji${BLUEH}Wave${RESET}™️ "
    echo -e "${WHITEB}14. ${PURPLE}Emoji${RED}Heart${RESET}💕 "
    echo -e "${WHITEB}15. ${BLACKH}Lunoji${RESET}🌜"
    echo -e "${WHITEB}16. ${CYANB}CosmiQ${RESET}♏"
    echo -e "${WHITEB}17. ${BLUE}Tokyo${YELLOW}Tuner${RESET}🉐"
    echo -e "${WHITEB}18. ${REDB}Volume${GREENB}Vibes📘${RESET}"
    echo -e "${WHITEB}19. ${BLACKH}Disk${WHITEH}Beats⚫${RESET}"
    echo -e "${WHITEB}20. ${BLUEH}Display \e[40;37;5;82m Qr-\e[30;47;5;82mCode${RESET}."    
    echo -e "${WHITEB}21. ${BOLDU}Exit${RESET}"
    echo -e "${WHITEB}"
    read -p "Enter your choice [1-20]: " choice

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
            start_symbols_style
            ;;
        6)
            start_blueberry_pulse_style
            ;;
        7)
            start_banana_groove_style
            ;;
        8)
            start_inferno_pulse_style
            ;;
        9)
            start_symbolStorm_style
            ;;
        10)
            start_tetris_style
            ;;
        11)
            start_flicker_style
            ;;
        12)
            start_gray_style
            ;;
        13)
            start_emojiwave_style
            ;;
        14)
            start_emojiheart_style
            ;;
        15)
            start_lunoji_style
            ;;
        16)
            start_cosmiq_style
            ;;
        17)
            start_tokyotuner_style
            ;;
        18)
            start_volumeVibes_style
            ;;
        19)
            start_diskBeats_style
            ;;
        20)
            print_qr_code
            ;;
        21)
            echo -e "${GREENB}G${GREEN}oo${GREENB}dbye${RESET}!"
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
sleep 1
main_menu
