# Disable greeting
set fish_greeting

# Key bindings

## Bind `Ctrl+Backspace` to delete a word behind the cursor
bind \b backward-kill-word

## Bind `Ctrl+Delete` to delete a word after the cursor
bind \e\[3\;5~ kill-word

# Variables

## Set the cursor theme
set -gx XCURSOR_THEME Adwaita

## Make `less` not open a window if text takes up less space
set -gx LESS -FXRI

## Set the quotes' color to green
set -gx fish_color_quote green

## Let the GPG program use the terminal connected to standard input
set -gx GPG_TTY (tty)

## Disable `direnv`'s output
set -gx DIRENV_LOG_FORMAT ""

# Set up the SSH agent (via `gnome-keyring`)
set -gx SSH_AUTH_SOCK /run/user/1000/keyring/ssh

# Store Go data files in an appropriate location
set -gx GOPATH ~/.local/share/go

# Add installed Go binaries to the path
fish_add_path $GOPATH/bin
