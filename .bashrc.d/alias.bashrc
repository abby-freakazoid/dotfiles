# NOTE
# ====
# - /etc/bash/bashrc.d/artix.bashrc alredy provides --color=auto aliases
# - interactive operations are safer
# - using sudo will forego all aliases. instead use su or specify command in full
# - do NOT make functions with same name of shell built-ins. they create infinite loops
#   inversely, using

# bootstrap
# =========
alias esed='sed -E'
ref_alias() {
	alias $1 | esed "s/.*='(.*)'/\1/" # in loving memory of wrap.sh
}

#alias sudo='doas'  # yay uses sudo to install things. it gets v confused by the flags of doas

# alias cal="cal --monday"  # assume sane ISO default instead of insane ANSI

# make
# ====
# make sure we neither use only one core nor slam the cpu @ 100%
core_count=$(lscpu -p=core | sed '/^#/d' | sort -u | wc -l)
thread_count=$(lscpu -p=cpu | sed '/^#/d' | wc -l)
load_limit=$(echo "$thread_count * 0.9" | bc -l)
alias make="make -j$((core_count + 1)) -l$load_limit"
alias parallel="parallel -j$((core_count + 1)) -l$load_limit"

# kernel make config
# ==================
# commands i used to use @ gentoo
# alias mk = make w/ all the stuff above
# alias kconf='pushd /usr/src/linux; mk menuconfig; popd'
# alias kmake='pushd /usr/src/linux; mk && mk modules_install && mk install; popd'

# just set the mode var, and use rmlint to clean up wrong files
# chmod
# =====
# alias 600='chmod 600'
# alias 700='chmod 700'

# cp mv rm
# ========
alias cp='cp --interactive --preserve=all --no-dereference --verbose'
# --preserve=all    preserve custom metadata (eg embedded hashsum)
# --no-dereference  copy links as links instead of as files
alias mv='mv --interactive --verbose'
alias rm='trash'
alias RM='/bin/rm --interactive --verbose'

# safety alias
alias rmdir="echo use find instead. this will delete NON-EMPTY directories on mtp mounts!"
alias RMDIR="/usr/bin/rmdir"

# merge merge-cp
# function merge-mv {
#   find "$1" | xargs echo mv --no-clobber -- target-directory="$2"
# }

# ls
# ==
export LS_COLORS="*.avif=38;5;133" # make avif files appear as regular media files
if ! which exa &>/dev/null; then
	alias ls='ls --group-directories-first --color=auto --human-readable'
	alias l="$(ref_alias ls)"
	alias la="$(ref_alias ls) --almost-all"
	alias ll="$(ref_alias ls) -l --sort=time"
else
	alias ls='exa --group-directories-first'
	alias l="$(ref_alias ls) --sort=Name"
	alias la="$(ref_alias ls) --all"
	alias ll="$(ref_alias ls) --long --sort=date"
fi

# tree
# ====
alias tree="$(ref_alias ls) --tree" # who needs to install an 80K executable when you have alias?
function t { tree --level="$@"; }

alias less='less --raw-control-chars'
# --raw-control-chars  resolve ANSI sequences

# hide output bloat
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
# -hide_banner  hide spammy text where ffmpeg describes its build conditions
alias milky='milkytracker -nosplash'
alias gdb='gdb --quiet'

#alias egrep='grep -E'  # exists as /usr/bin/egrep

#alias w3m='W3M_IMG2SIXEL=convert-sixel-stdout.sh w3m -sixel'

#function cs { cd -- "$@" && ls; }  # change + list directory
# change + list in stderr directory
function cd {
	# builtin cd "$@" && l >&2
	__zoxide_z "${!#}" && l >&2
}
ii() {
    __zoxide_zi "$@" && l >&2
}

function printf+wc {
	printf "$@" | wc
}

# hacky way to fix scrolling manpages in tmux
function man {
	if [[ -n "$TMUX" ]]; then
		tmux set mouse off
		# /usr/bin/man "$@"
		# lang does not have to be set with -L
		#/home/a/.nix-profile/bin/man "$@"
		/bin/man "$@"
		tmux set mouse on
	else
		/bin/man "$@"
	fi
}

#function mcd { mkdir "$@"; cd -- "$@"; }  # make + change directory
#function mcdm {}  # make + change directory + move file into directory

# aliases from retired files. not necessarily useful
alias tu='units --terse'
#alias dec-to-hex=''
# alias sinfo='info --subnodes'  # output manpage-style

# for functions that make more sense to be dynamically edited before execution:
# alias fzfn='cat /usr/local/bin/scripts/shell-oneliners | fzf'
# shell history search, like C-r
alias r="cat ~/Quellcode/scripts/helper/shell-oneliners | fzf"
# have several Obsidian docs about this
# also use
# - man
# - tldr
# - navi

# alias halt='doas halt'

# function fixTermName() {
#     echo -en '\033]2;'$TERM'\007'
# }

alias bpytop="bpytop; echo -en '\033]2;'$TERM'\007'"
alias telescope="telescope; echo -en '\033]2;'$TERM'\007'"

# alias mount="sudo mount -o nosuid\,nodev\,noexec"
# TODO: maybe use CAPS style to differentiate fuctionality?
function mount {
	if [ "$#" -gt 0 ]; then
		echo sudo /bin/mount -o nosuid,nodev,noexec "$@"
	else
		/usr/bin/mount
	fi
}

# # apt-based p-style syntax
# which apt &> /dev/null
# if [ $? -eq 0 ]; then
#   alias p='apt'
# fi

# pacman-based p-style syntax
which pacman &>/dev/null
if [ $? -eq 0 ]; then
	alias p='sudo pacman'
	# alias pi='doas pacman --sync'                         # pacman -S;   install
	# alias pr='doas pacman --remove --cascade --recursive' # pacman -Rcs; remove
	# alias pu='doas pacman --sync --refresh --sysupgrade'  # pacman -Syu; upgrade; use second --refresh -y to force refresh
	# alias pq='yay --sync --search'                   # yay -Ss;     query;   use second --search -s for AND expression
fi

# use 'pkill -SIGUSR1 swayidle' instead
# alias swaylock="swaylock -c 000000"

alias k=kak

# NOTE: I use Obsidian for zettelkasten journaling now

# curJournal='~/journal/$(date +%F)'
# alias j="date +%T | sed 's/$/\n/' >> $curJournal; kak +: $curJournal"

# alias J="~/.l/src/scripts/journal.sh"

# function j {
#     if [ -z "$1" ]; then
#         curJournal="~/journal/$(date -d now +%F)"
#         date +%T | sed 's/$/\n/' >> $curJournal
#     else
#         curJournal=~/journal/$(date -d "$@" +%F)
#     fi

#     kak +: $curJournal
# }

# alias mpv="mpv --audio-device=jack"

# find . -maxdepth 1 -type f | sxiv-mv <destination>
alias sxiv-mv="sxiv -io | xargs $(ref_alias mv) --target-directory"
alias zk-sxiv="zk graph --format json > ~/.l/cache/zk.graph.json; pystache ~/journal/template.48-2.mustache ~/.l/cache/zk.graph.json | fdp -Tpng -ofdp.png; sxiv fdp.png &"

# NOTE when sxiv says that there is no locale support, it means that it cant find the locale archive
alias sxiv="sxiv -a"

# NOTE: actually, just use keepassxc+keepassdx or bitwarden
#alias gpg="sudo -u gpg gpg"
# just add a password to my keys. gpg caches the password like sudo. i think

#
# simple english
#

alias newfetch=neofetch

#
# outdated
#

alias makewhatis=mandb
alias mandb="echo sudo mandb"

alias arch="uname"

alias dog=doge

#
# nix
#

# alias mpv="nixGLIntel mpv"

alias brave="firejail --profile=.l/cfg/firejail/nixGLIntel.local nixGLIntel brave"

nix-grep() {
	# grep "$1" nix-packages.csv | column -ts,
	zstdcat $XDG_CACHE_HOME/nix-packages.csv.zst | grep "$1" | column -ts,
}

# oneliner-grep () {
#     # grep "$1" nix-packages.csv | column -ts,
#     zstdcat $XDG_CACHE_HOME/nix-packages.csv.zst | grep "$1" | column -ts,
# }

# sed-mv() {
#    cmd=$2
#    for f in *; do $2;done
# }

alias pass-gen='< /dev/urandom tr -dc A-Za-z0-9 | head -c'

alias conda-activate='source /opt/anaconda/bin/activate root'

# update channel
# update packages
# delete old generations (leave 5 newest)
# garbage collect orphaned package versions
# hardlink duplicates (takes ~5 min)
alias nix-update="set -v; nix-channel --update; nix-env -iA all-env -f '<nixpkgs>'; nix-env --delete-generations +5; nix-collect-garbage; nix-store --optimise; set +v"

alias progress-sync="watch -d grep -e Dirty: -e Writeback: /proc/meminfo"
alias sync-progress=progress-sync

alias rsync="rsync --human-readable --info=progress2,stats2 --timeout=30"

# NOTE: this is to prevent double-syncing. usermode dnf has its own cache
alias dnf="echo RUN AS ADMIN OR WITH /bin/dnf"

alias rmlint="rmlint --progress"

alias mullvad-check="curl https://am.i.mullvad.net/connected"

alias du="du -h"

alias rsync-obsidian='rsync -az --inc-recursive --delete --exclude ".*" ~/Dokumente/Obsidian pixel:Documents/'

alias venv-activate='. .venv/bin/activate'

alias lute='python -m lute.main --port 9876'

alias tor-check="curl --silent https://check.torproject.org/ | grep 'using Tor' | sed 1q"

alias alias-edit="kak /home/a/.bashrc.d/alias.bashrc; . /home/a/.bashrc.d/alias.bashrc"
alias env-edit="kak /home/a/.bashrc.d/env.bashrc; . /home/a/.bashrc.d/env.bashrc"
alias completion-edit="kak /home/a/.bashrc.d/completion.bashrc; . /home/a/.bashrc.d/completion.bashrc"

alias column-tsv="column --table --separator=$'\t'"

alias table='echo use column-* instead'

alias basedir="echo USE dirname; dirname"

# alias python-lint="flake8 --ignore=E203,E501,E722,W503"

# alias cargo="cargo --config="

alias vscode=codium
alias code=codium

unset -f ref_alias
