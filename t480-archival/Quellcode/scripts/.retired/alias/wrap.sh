#!/bin/env sh
# I just solved the alias self-reference problem. this project is now effectively retired.
# godspeed to you, lil file. you helped me a lot.
# RIP, 2022-03-27 16:24 UTC

oldPATH=$PATH
PATH=$(echo "$PATH" | sed 's|/home/a/src/bin/wrap:||')
PATH=$(echo "$PATH" | sed 's|~a/src/bin/wrap:||')
PATH=$(echo "$PATH" | sed 's|/usr/local/sbin:||')

case "$(basename "$0")" in
  # NOTE: it is unsafe to overwrite POSIX utilities. build pipelines have already been disrupted
  #cp)         name='rsync';  PATH="$bATH"
  #cp) x='cp --preserve=all --interactive --no-dereference';;
  #mv) x='mv --interactive';;
  #rm) x='rm --interactive';;
  
  #ls)                  x='exa --group-directories-first';;  # --classify
  #l)  PATH="$oldPATH"; x='ls  --tree --level=1';;
  #la) PATH="$oldPATH"; x='ls  --all';;
  #ll) PATH="$oldPATH"; x='ls  --long --sort=date';;

  #l2) PATH="$oldPATH"; x='ls  --tree --level=2';;
  #l8) PATH="$oldPATH"; x='ls  --tree';; # infinity
  
  # ls)                  x='ls --quoting-style=literal --color=auto';;  # hotfix
  # la) PATH="$oldPATH"; x='ls --almost-all';;
  # l)  PATH="$oldPATH"; x='la --group-directories-first --human-readable --sort=version';;
  # ll)           name='l';     PATH="$bATH"
  #                 args='--format=long';;

  # i think this was necessary because some build pipeline wanted to use cc and c99
  #c99) x='gcc';;
  #cc)  x='gcc';;

  # using generalized names is not nice. it may seem more convenient, but i can keep track of names as is
  #editor)  x='emacsclient --socket-name=/tmp/1000/emacs-editor/server';;
  #browser) x='emacsclient --socket-name=/tmp/1000/emacs-browser/server';;

  #grep)                   x='grep --color=auto';;  
  #egrep) PATH="$oldPATH"; x='grep -E';;

  #esed)  x='sed -E';;

  #less) x='less -r';;
 
  # rsync)        args='--verbose --archive --compress';;
  # -a, --archive = -rlptgoD (no -H,-A,-X)
  # -r, --recursive
  # -l, --links		copy symlinks as symlinks
  # -p, --perms		preserve permissions
  # -t, --times		perserve mtime
  # -U, --atimes	preserve atime
  # -g, --group		preserve group
  # -o, --owner		preserve owner
  # -D			= --devices --specials
  #     --devices	preserve device files
  #     --specials	preserve special files
  # -X, --xattrs	preserve extrended attributes
  #rsync) x='rsync --verbose --recursive --links --perms --times --group --owner -- --xattrs --new-compress';;
  
  # ngrep)      name='grep'
  #               args='-n';;
  # nless)      name='less'  # cool name, but useless
  #               args='-N';;
  
  #600) x='chmod 600';;
  #700) x='chmod 700';;
  
  #gvim) x='o';;  # i think this was cuz xfce4 wants to open gvim by default as editor, or maybe its firefox
  #youtube-dl)   x='~/dev/remote/github.com/yt-dlp/yt-dlp/yt-dlp';;
  #dl)        x='youtube-dlc';;
  #sxiv)      x='sxiv -a';;
  #mk)        x='make -j9 -l14.4';;
  #kconf)     x='pushd /usr/src/linux; mk menuconfig; popd';;
  #kmake) PATH="$oldPATH"; x='pushd /usr/src/linux; mk && mk modules_install && mk install; popd';;
  #pass-gen)  x='< /dev/urandom tr -dc A-Za-z0-9 | head -c';;
  #su)  cd ~"$@"; su;;  # not necessary. just use `su -`
  *) echo retired; exit 1;;
esac

#exec $x "$@" <&0
