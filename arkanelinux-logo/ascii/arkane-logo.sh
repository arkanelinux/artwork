#!/usr/bin/env bash

# Based on hyfetch by hykilpikonna
# https://github.com/hykilpikonna/hyfetch
# Code licensed under the MIT License
#
# ASCII art licensed under the CC BY-SA by Arkane Linux and Karina Plaksina

set_text_colors() {
    if [[ "${colors[0]}" == "distro" ]]; then
        title_color="$(color "$1")"
        at_color="$reset"
        underline_color="$reset"
        subtitle_color="$(color "$2")"
        colon_color="$reset"
        info_color="$reset"

        # If the ascii art uses 8 as a color, make the text the fg.
        ((${1:-1} == 8)) && title_color="$reset"
        ((${2:-7} == 8)) && subtitle_color="$reset"

        # If the second color is white use the first for the subtitle.
        ((${2:-7} == 7)) && subtitle_color="$(color "$1")"
        ((${1:-1} == 7)) && title_color="$reset"
    else
        title_color="$(color "${colors[0]}")"
        at_color="$(color "${colors[1]}")"
        underline_color="$(color "${colors[2]}")"
        subtitle_color="$(color "${colors[3]}")"
        colon_color="$(color "${colors[4]}")"
        info_color="$(color "${colors[5]}")"
    fi

    # Bar colors.
    if [[ "$bar_color_elapsed" == "distro" ]]; then
        bar_color_elapsed="$(color fg)"
    else
        bar_color_elapsed="$(color "$bar_color_elapsed")"
    fi

    if [[ "$bar_color_total" == "distro" ]]; then
        bar_color_total="$(color fg)"
    else
        bar_color_total="$(color "$bar_color_total")"
    fi
}

color() {
    case $1 in
        [0-6])    printf '%b\e[3%sm'   "$reset" "$1" ;;
        7 | "fg") printf '\e[37m%b'    "$reset" ;;
        "#"*)
            local rgb="${1//#}"
            rgb="$((0x$rgb))"
            printf '\e[38;2;%b;%b;%bm' "$((rgb >> 16))" "$(((rgb >> 8) & 0xff))" "$((rgb & 0xff))"
        ;;

        *)        printf '\e[38;5;%bm' "$1" ;;
    esac
}

set_colors() {
    c1="$(color "$1")${ascii_bold}"
    c2="$(color "$2")${ascii_bold}"
    c3="$(color "$3")${ascii_bold}"
    c4="$(color "$4")${ascii_bold}"
    c5="$(color "$5")${ascii_bold}"
    c6="$(color "$6")${ascii_bold}"

    [[ "$color_text" != "off" ]] && set_text_colors "$@"
}

set_colors 130 130 237 15
cat <<EOF
$(tput bold)${c3}                    .:..
                 ..:::......
           ${c1}.${c3}   .${c1}.${c3}.....
           ${c1}+=${c3}...${c1}==${c3}....
   ......:.${c4}:-${c1}:${c3}..${c4}+*${c1}=${c3}....
            ${c1}:----::${c3}......
          ${c1}.=***##*+=:    ${c3}..
         ${c1}=${c4}***######*${c1}=
          ${c1}.${c4}-*######+
         ${c1}:+${c4}###%%%###${c3}:
         ${c1}-+*${c4}########+${c3}.
         ${c1}=++*${c4}#######${c3}-
        ${c1}-+=+**${c4}*####${c3}=
     ${c3}.${c1}-=++==***${c4}##*${c3}-
    ${c1}-++++++==++++=
  .-+++**+++=+===${c3}.
${c1}:---===++++=-=--${c3}.
${c1}-===============${c3}-==--:
${c1}.-==+++***++*${c4}*#########${c3}=:::.
 ${c1}.-=++++*++++**${c4}#######%%###${c3}=
   ${c1}.:==++++++**${c4}#############${c3}:
            ${c1}.${c3}-+*++*+++==${c4}###${c3}+
                       -${c4}*+${c3}:
EOF

