eval "$(starship init bash)"

if [[ "$TERM_PROGRAM" =~ "vscode" ]]; then
	export STARSHIP_CONFIG=~/.config/starship-vscode.toml
fi
