# doesnt accept $? without escape
# \t actually escapes to time, not TAB

# see:
# - https://wiki.archlinux.org/title/Bash/Prompt_customization

# \[ and \] help the shell correctly calculate prompt length for wraparound
# they are bashism aliases for \001 (^A) and \002 (^B). those are control chars for readline (the utility bash uses to display its prompt)

# function c {
#     # \e = \[\033 = \x1b
#     printf '\e['  # ansi escape preamble

#     # 0; no op
#     # 1; no op
#     # 2; invis
#     # 3; no color

#     # color code anatomy:
#     # a;b;c;d
#     # a = invis, activate extended colors (optional)
#     # b = foregroud color
#     # c = foregroud effect
#     # d = background color

#     # 5;#           = arbitrary colors (1 #)
#     # ...
#     # 5;########    = arbitrary colors (8 #)

#     # invalid:
#     # ;#;
#     # 5;#;1
#     # 5;##;0
#     # 5;#########    (9 #)


#     # see https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences/33206814

#     # ANSI commands
#     # 30..37    set color, 4-bit regular (8 colors)
#     # 38        set color, arbitrary
#     # 90..97    set color, 4-bit bright (8 colors)

#     # 4-bit color range (see case statement below)

#     # 8-bit color range
#     # 0x00-0x07:  standard colors (same as the 4-bit colours)
#     # 0x08-0x0F:  high intensity colors
#     # 0x10-0xE7:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
#     # 0xE8-0xFF:  grayscale from black to white in 24 steps

#     # set foreground color
#     # --------------------
#     [ -z "$2" ] && printf '3' || printf '9'  # brightness / intensity

#     case $1 in
#         black)      printf '0';;
#         red)        printf '1';;
#         green)      printf '2';;
#         yellow)     printf '3';;
#         blue)       printf '4';;
#         magenta)    printf '5';;
#         cyan)       printf '6';;
#         white)      printf '7';;
#     esac

#     printf 'm'  # m\]
# }

# A="$(c cyan)"  # accent
# C="$(c magenta)"  # contrast, inverse accent

# the above is nice to have as a reference, but its not really necessary since we have tput
# i should move the commented out stuff into my wiki.info and make a section on standards / rfcs to reference. and ascii table would be nice n useful

# ISO-6429: ECMA-48: SELECT GRAPHIC RENDITION 0 or "reset colors"
E="\[$(tput sgr0)\]"  # end

A="\[$(tput setaf 6)\]"  # cyan		accent
C="\[$(tput setaf 5)\]"  # magenta	contrast, inverse accent

# — em dash
# \t = time (w/ seconds)

time="\D{%H}$A:$E\D{%M}$A:$E\D{%S}"  # time

PROMPT_COMMAND='exitStatus=$?'  # preserve and expose exit status to entire shell

# rightprompt()
# {
#     [ $exitStatus -ne 0 ] && echo $C
#     # inside functions, it is always waited to evaluate vars
#     printf "%*s" $COLUMNS "$A[$E"$exitStatus
# }
# \[$(tput sc; rightprompt; tput rc)\]

USER_COLOR="1;32"

# $A┌[$E"'$([ $exitStatus -ne 0 ] && echo '"$C"')$exitStatus'"$E$A]—[$E\#/\!$A]—[$E\w$A]$E\n\
# $A┌[$E"'$([ $exitStatus -ne 0 ] && echo '"$C"')$exitStatus'"$E$A]—[$E\#$A]—[$E\w$A]$E\n\

# PS1="\
# $A┌[$E\w$A]$E\n\
# $A└[$E$time$A]>$E "  # directly before command, after output

# PS1='\e[${USER_COLOR}m[ ${USER}@${HOSTNAME} ]\e[1;35m~\e[1;34m[ $PWD ]$(printf "%$(($COLUMNS - 9 - 5 - ${#USER} - ${#HOSTNAME} - ${#PWD} - 8))s")\e[1;33m[ \t ]\e[m\n$ '

PS1="\
$A[$E \u@${HOSTNAME} $A]-\
[$E \w $A]$E"'\
$(printf "%$(($COLUMNS - 9 - 1 - 5 + 1 - ${#USER} - ${#HOSTNAME} - ${#PWD} + $(echo ${PWD} | grep -q ${HOME} && echo 6) - 8))s")'"\
$A[$E $time $A]\n\
"'$'"$E "

# PS0="$E"  # directly after command, before output

# the funky characters are pretty, but they make blesh freak out
