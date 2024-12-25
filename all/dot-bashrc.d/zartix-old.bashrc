# /etc/bash/bashrc

# i no longer extend PATH. just put scripts in /usr/local/bin

shopt -s autocd

GLOBIGNORE=.:..  # exclude ./ and ../ from *
shopt -s dotglob  # include hidden files in *

# export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"  # syntax highlighting for less
#export LESSOPEN="| ~/.nix-profile/bin/src-hilite-lesspipe.sh %s"
