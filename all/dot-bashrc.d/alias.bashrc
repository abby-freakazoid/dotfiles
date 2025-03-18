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
if ! which exa &>/dev/null; then
	alias tree="$(ref_alias ls) --tree" # who needs to install an 80K executable when you have alias?
	function t { tree --level="$@"; }
fi

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
# alias dnf="echo RUN AS ADMIN OR WITH /bin/dnf"
alias dnf="dnf --cacheonly"

alias rmlint="rmlint --progress"

alias mullvad-check="curl https://am.i.mullvad.net/connected"

alias du="du -h"

alias rsync-obsidian='rsync -az --inc-recursive --delete --exclude ".*" ~/Dokumente/Obsidian pixel:Documents/'
alias rsync-dcim='rsync -az --remove-source-files pixel:DCIM/Camera/ Bilder/pixel/DCIM/Camera/'

alias venv-activate='. .venv/bin/activate'

alias lute='python -m lute.main --port 9876'

alias tor-check="curl --silent https://check.torproject.org/ | grep 'using Tor' | sed 1q"

alias alias-edit="kak /home/a/.bashrc.d/alias.bashrc; . /home/a/.bashrc.d/alias.bashrc"
alias env-edit="kak /home/a/.bashrc.d/env.bashrc; . /home/a/.bashrc.d/env.bashrc"
alias completion-edit="kak /home/a/.bashrc.d/completion.bashrc; . /home/a/.bashrc.d/completion.bashrc"

edit-rc() {
	kak /home/a/.bashrc.d/"$1".bashrc
	. /home/a/.bashrc.d/"$1".bashrc
}

alias column-tsv="column --table --separator=$'\t'"
alias column-csv="column --table --separator=,"

alias table='echo use column-tsv instead; :'

alias basedir="echo USE dirname; dirname"

# alias python-lint="flake8 --ignore=E203,E501,E722,W503"

# alias cargo="cargo --config="

alias vscode=codium
alias code=codium

# have been typing this by hand for a while, not new:
alias shuf_fixed="shuf --random-source ~/.local/share/shuf.seed"

# tried this before shuf_group-by-dir, but I store files and folder side-by-side, so it didn't work out
# SEE: stackoverflow.com/questions/4269798/use-gnu-find-to-show-only-the-leaf-directories
# find_only-leaf-dirs() {
# 	# find "$1" -type d -links 2
# 	find "$1" -type d -exec sh -c '(ls -p "{}" | grep / >/dev/null) || echo "{}"' \;
# }

alias psgrep=pgrep

venv-create() {
	! [ -d .venv ] && python3 -m venv .venv
	venv-activate
}

# Usage: github-clone.sh URL
# NOTE: ammendment: now dot dir by default

# git clone $1 /usr/local/src/$(echo $1 | sed 's|.*://||')

github-clone() {
	path=~/Quellcode/.$(echo $1 | sed 's|.*://||')
	! [ -d $path ] && git clone $1 $path
	# use pushd instead of cd, so I can popd when I'm done
	pushd $path && l >&2
}

# improvements over below:
# - urls never contain spaces, so quotes are spurious
# - now i can paste urls as is

# Old Usage: git-clone PROTOCOL URL
# NOTE: space is important

# gitDir=~a/dev/remote
# subDir="$(echo "$1" | sed 's|/|\t|' | cut -f1-2)"

# mkdir -p "$gitDir"/"$subDir"; cd "$gitDir"/"$subDir" || exit $?

#git clone "$1$2" /usr/local/src/"$2"

alias whic=which
# alias license="cargo generate-license"
alias sloc=tokei
alias loc=tokei
alias cloc=tokei

# NOTE: comments behind editor presets are for github stars

# alias nvim-chad="NVIM_APPNAME=nvchad nvim" # 23.3k, almost nothing pre-included
# alias nvim-lunar="NVIM_APPNAME=lunarvim nvim" # 17.6k, a lil jank. changed hands
# alias nvim-lua="NVIM_APPNAME=nvimlua nvim" # 15.8k, almost nothing pre-included
alias nvim-lazy="NVIM_APPNAME=lazyvim nvim" # 13.7k
# alias nvim-astro="NVIM_APPNAME=nvim-astro nvim" # 12.1k, broken
alias nvim-astro="NVIM_APPNAME=nvim-astro nvim" # 12.1k, broken
alias astro=nvim-astro
alias nvim=nvim-astro
alias vim=nvim-astro
# alias nvim-nyoom="NVIM_APPNAME=nyoom nvim" # 1.3k, broken?
# alias nvim-cosmic="NVIM_APPNAME=cosmicnvim nvim" # 1.1k, broken / outdated

# also tested for -nw (no window system / terminal / text only mode)
alias emacs-space="emacs --init-directory ~/.config/spacemacs/" # 23.5k
# alias emacs-doom="~/.config/emacs-doom/bin/doom run" # 18.7k, broken
alias emacs-doom="emacs --init-directory ~/.config/emacs-doom/" # 18.7k, broken

# alias emacs-purcell="emacs --init-directory ~/.config/purcell/" # 6.8k, refuses being closed by default
# alias emacs-prelude="emacs --init-directory ~/.config/prelude/" # 5.1k, unclear how to enable evil mode
# alias emacs-graphene="emacs --init-directory ~/.config/graphene/" # 5.1k, broken
# alias emacs-centaur="emacs --init-directory ~/.config/centaur-emacs/" # 1.9k, reopens last file, even when I instruct it otherwise from cli

alias helix=hx

alias pgp=gpg

touch() {
	mkdir --parents "$(dirname "$@")"
	/bin/touch "$@"
}

alias comp="echo use diff or uniq"
alias count="echo use uniq"

alias ipython=bpython

alias filename=basename

alias whisper="whisper --verbose False --model base --output_format vtt"

alias astro-edit="astro /home/a/.config/nvim-astro/lua/"

alias bat="bat --wrap=never"

alias rg="rg --no-ignore-parent"

alias my="$(ref_alias mv)"

alias bar="$(ref_alias bat)"

tmux-colors() {
	for i in {0..255}; do
		printf "\x1b[38;5;%smcolour%s\n" "${i}" "${i}"
	done
}

alias gh-cli=gh

alias where="which --all"

alias sudoeit=sudoedit

alias kak-edit="kak ~/.config/kak/kakrc"
alias edit-kak=kak-edit

alias sshd="/sbin/sshd -f ~/.ssh/sshd_config -h ~/.ssh/ssh_host_ed25519_key"

# ! -t *UTF8 renders well, but small
# ! -t ASCII, ASCIIi aren't picked up well
# ! -t EPS (encapsulated PostScript) is an obscure format and requires conversion
# ! -t PNG renders corrupt in sixel
# -t ANSI, ANSI256 show up the best in terminal
# -t PNG32, SVG, XPM render images viewable in sxiv
alias qrencode="qrencode -t ANSI256 -l Q"

# alias sort="LANG=C sort"

alias figlet="figlet -d ~/.local/share/figlet"
alias figlist="figlist -d ~/.local/share/figlet"
alias showfigfonts="showfigfonts -d ~/.local/share/figlet"

alias git-edit="git config --edit --global"

# distutils was deprecated and moved into setuptools in Python 3.12
# the docker compose subcommand was installed via:
# curl -o ~/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64
# chmod +x ~/.docker/cli-plugins/docker-compose
alias docker-compose="docker compose"

alias bpythop=bpytop

alias lskblk=lsblk

# cursor not released by default Shift+F12 on machines that use function keys
alias virt-viewer="virt-viewer --hotkeys=release-cursor=ctrl+alt"

alias edit-alias=alias-edit

# alias monerod="monerod --detach --enable-dns-blocklist --out-peers 16 --no-igd --bootstrap-daemon-address auto --no-sync --check-updates disabled --non-interactive --max-concurrency 4"
# alias monerod="monerod --detach --enable-dns-blocklist --out-peers 16 --no-igd --bootstrap-daemon-address auto --max-concurrency 4"

MONERO_DIR=/nfs/

if [ "$HOSTNAME" == "fedora" ]; then
	MONERO_DIR=$MONERO_DIR/exports
else
	MONERO_DIR=$MONERO_DIR/imports
fi

MONERO_DIR=$MONERO_DIR/archive/.bitmonero

# PULIC DNS var needed to fix DNS error
alias monerod="DNS_PUBLIC='tcp://8.8.8.8' ~/Packages/monero-x86_64-linux-gnu-v0.18.3.4/monerod --prune-blockchain --enable-dns-blocklist --detach --max-concurrency=1 --data-dir=$MONERO_DIR"

alias monerod-progress="tail -f $MONERO_DIR/bitmonero.log"
alias monero-progress=monerod-progress

alias hollywood="docker run --rm -it bcbcarl/hollywood"

alias cmatrix=unimatrix

unset -f ref_alias
