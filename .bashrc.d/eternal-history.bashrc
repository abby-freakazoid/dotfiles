# Eternal Bash History
# ====================
# Undocumented feature which sets the size to "unlimited"
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
#HISTFILESIZE=
#HISTSIZE=
#HISTTIMEFORMAT="[%F %T] "  # setting this is actually very important. without the interruptions, ble.sh will assume commands are first multiline commands, then normal commands. it will attempt to append the entire history as a single command if the up arrow is hit
# the format itself is only important for what running "history" will return
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
#HISTFILE=~/.bash_eternal_history

# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# Avoid duplicates
# note that commands only count as duplicates if they come in direct succession. if first "echo hello" then "echo world" is run in repetition, theyre not considered duplicates
#HISTCONTROL=ignoredups:erasedups
#shopt -s histappend  # when the shell exits, append to the history file instead of overwriting it

# the below command is dangerous. it duplicates shell history each time another window is launched and closed
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"  # after each command, append to the history file and reread it
