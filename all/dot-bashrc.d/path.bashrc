# Append "$1" to $PATH when not already in.
# This function API is accessible to scripts in /etc/profile.d
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# Append default paths
append_path "$HOME/Quellcode/scripts"
append_path "$HOME/.local/share/android-home/cmdline-tools/latest/bin"
append_path "$HOME/.yarn/bin"
append_path "$HOME/Android/Sdk/platform-tools/"
append_path "$HOME/.local/share/npm/bin"
append_path "$HOME/.local/share/gem/ruby/3.0.0/bin"
append_path "$HOME/.local/share/gem/bin"
#append_path "$HOME/.l/bin"
#append_path "$HOME/.l/python/bin"
#append_path "$HOME/.nix-profile/bin"
#append_path "$HOME/.l/share/gem/ruby/3.0.0/bin"

# Force PATH to be environment
#export PATH

# Unload our profile API functions
unset -f append_path
