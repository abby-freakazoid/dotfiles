if ! which exa &>/dev/null; then
	eval "$(pip completion --bash)"
fi
# eval "$(rustup completions bash)"
eval "$(rustup completions bash cargo)"
eval "$(zoxide init --cmd i bash)"
