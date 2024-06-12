# Reset
NoColour=$'%{\e[0m%}'

# Regular Colors
Black=$'%{\e[0;30m%}'
Red=$'%{\e[0;31m%}'
Green=$'%{\e[0;32m%}'
Yellow=$'%{\e[0;33m%}'
Blue=$'%{\e[0;34m%}'
Purple=$'%{\e[0;35m%}'
Cyan=$'%{\e[0;36m%}'
White=$'%{\e[0;37m%}'

# Bold
BBlack=$'%{\e[1;30m%}'
BRed=$'%{\e[1;31m%}'
BGreen=$'%{\e[1;32m%}'
BYellow=$'%{\e[1;33m%}'
BBlue=$'%{\e[1;34m%}'
BPurple=$'%{\e[1;35m%}'
BCyan=$'%{\e[1;36m%}'
BWhite=$'%{\e[1;37m%}'


show_colours() {
    echo "Showing available colour variables"
    print -P "${NoColour}NoColour"
    print -P "${Black}Black"
    print -P "${Red}Red"
    print -P "${Green}Green"
    print -P "${Yellow}Yellow"
    print -P "${Blue}Blue"
    print -P "${Purple}Purple"
    print -P "${Cyan}Cyan"
    print -P "${White}White"
    print -P "${BBlack}BBlack (Bold Black)"
    print -P "${BRed}BRed (Bold Red)"
    print -P "${BGreen}BGreen (Bold Green)"
    print -P "${BYellow}BYellow (Bold Yellow)"
    print -P "${BBlue}BBlue (Bold Blue)"
    print -P "${BPurple}BPurple (Bold Purple)"
    print -P "${BCyan}BCyan (Bold Cyan)"
    print -P "${BWhite}BWhite (Bold White)"
}
