# PWD = HOME: only run tmux when not opened as "open terminal here"

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ] && [ "$PWD" = "$HOME" ]; then
    tmux attach || tmux >/dev/null 2>&1
fi
