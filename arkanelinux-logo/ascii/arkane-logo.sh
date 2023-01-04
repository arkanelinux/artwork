#!/usr/bin/env bash

# Based on hyfetch by hykilpikonna
# https://github.com/hykilpikonna/hyfetch
# Code licensed under the MIT License
#
# ASCII art licensed under the CC BY-SA by Arkane Linux and Karina Plaksina

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

    [[ "$color_text" != "off" ]]
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

