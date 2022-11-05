# Disable greeting
set fish_greeting

# Key bindings

## Bind `Ctrl+Backspace` to delete a word behind the cursor
bind \b backward-kill-word

## Bind `Ctrl+Delete` to delete a word after the cursor
bind \e\[3\;5~ kill-word

# Variables

## Make `less` not open a window if text takes up less space
set -gx LESS -FXRI

## Set the quotes' color to green
set -gx fish_color_quote green

## Let the GPG program use the terminal connected to standard input
set -x GPG_TTY (tty)

# Aliases
alias ls=exa
alias cat=bat
alias cfg="nano ~/.config/fish/config.fish"
alias nvim="TERM=wezterm command nvim"

# Load the completion scripts of Podman
podman completion fish | source
