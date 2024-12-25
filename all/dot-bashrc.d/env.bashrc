# limit my .bashrc.d/ to only run in non-interactive mode.
# the shell my desktop is launced in keeps overriding settings set later

#export LOCALE_ARCHIVE=/lib/locale/locale-archive  # needed for nixpkgs to recognize locales
#export GPG_TTY=$(tty)  # necessary for git to work
#export PYTHONPATH=/usr/local/lib/python3.10/site-packages/
#export GOPATH=/home/a/.l/go/
export ZK_NOTEBOOK_DIR=/home/a/Dokumente/Journal
export LUTRIS_SKIP_INIT=1  # skip annoying update check. i use a fuckin package manager
#export XKB_DEFAULT_LAYOUT=de  # set keyboard for xorg and wayland
#export GTK_THEME=Adwaita:dark  # set dark theme (eg for firefox)

# tiling window manager options
#export _JAVA_AWT_WM_NONPARENTING=1  # fixes annoying issues with tiling WMs
# alias android-studio='_JAVA_AWT_WM_NONREPARENTING=1 android-studio'
# alias idea='_JAVA_AWT_WM_NONREPARENTING=1 idea'

# source theme for qt applications from qt5ct
#export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_QPA_PLATFORMTHEME=gtk+

# did this work? or was it turning on the trackpad in bios?
#export WLR_NO_HARDWARE_CURSORS=1

# export SDL_AUDIODRIVER=alsa
# maybe set this as an alias for steam. tho other applications may not repsect that.
# export LD_PRELOAD="/usr/lib/libasound.so.2"
# the above can also help with no audio for steam
# alias steam="SDL_AUDIODRIVER=alsa steam"

# fixes issue with qt apps under nix
#export QT_XCB_GL_INTEGRATION=none
#export RANGER_LOAD_DEFAULT_RC=FALSE

#export EDITOR="kak +"  # default editor. users can change via their shellrc or profile respectively. also jump to last line with +
export EDITOR="kak"

#export MOZ_ENABLE_WAYLAND=1  # enable wayland on stubborn tor

export RUSTC_WRAPPER=sccache  # cache compilation artifacts across crates

# export ANDROID_HOME="$HOME/.local/share/android-home"
# export ANDROID_SDK_ROOT="$ANDROID_HOME"

# NOTE: if something asks for CMAKE_CXX_COMPILER, just install g++. it probably is not installed, so it can't find it
# export CMAKE_CXX_COMPILER=g++

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export PYPICKUP_INDEX_PATH=/home/a/.local/share/pypickup

# force npm --global to install locally
export NPM_PACKAGES="$HOME"/.local/share/npm
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# export PAGER=bat  # man expects the pager to be less

# exit # do NOT do this. will actually kill current running shell, not exit source early

if [ -x "$(command -v tmux)" ] && # tmux is an executable
[ -n "${DISPLAY}" ] && # DISPLAY is set
[ -z "${TMUX}" ] && # TMUX is NOT set
[ "$PWD" = "$HOME" ] && # directory shell was called in is HOME
[[ $- == *i* ]] # we are interactive (may be checked at some earlier step tbh)
then
	# .197.181, .129.202
	# export http_proxy=http://192.168.157.141:3128  # pixel-set-ssh-ip
	# export https_proxy=$http_proxy
	:
fi
