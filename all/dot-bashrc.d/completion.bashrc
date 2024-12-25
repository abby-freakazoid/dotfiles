if ! which exa &>/dev/null; then
	eval "$(pip completion --bash)"
fi
# eval "$(rustup completions bash)"
eval "$(~/.cargo/bin/rustup completions bash cargo)"
eval "$(~/.cargo/bin/zoxide init --cmd i bash)"
[ -d /home/linuxbrew/.linuxbrew/etc/bash_completion.d/ ] && eval "$(cat /home/linuxbrew/.linuxbrew/etc/bash_completion.d/*)"
[ -d ~/.nix-profile/etc/profile.d/ ] && . /home/a/.nix-profile/etc/profile.d/nix.sh
# eval "$(atuin gen-completions --shell bash)"  # tried it out, and it broke starship.rs
