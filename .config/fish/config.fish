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

# Redefine the Neovim command to make it work as a server
function nvim
    # Define the named pipe
    set PIPE ~/.cache/nvim/server.pipe
    # If the server is up, connect to it and open the files
    if [ -e "/home/paveloom/.cache/nvim/server.pipe" ]
        # Using `--remote` with `$ARGS` is not enough:
        # it corrupts the session file. Send keys instead
        if [ -n "$argv" ]
            for arg in $argv
                command nvim --server "$PIPE" --remote-send ":e $(realpath $arg) <CR>"
            end
        else
            echo "The server is already running."
        end
    # Otherwise, start the server and open the files
    else
        if [ -n "$argv" ]
            command nvim --listen "$PIPE" (realpath $argv)
        else
            command nvim --listen "$PIPE"
        end
    end
end

# Load the completion scripts of Podman
podman completion fish | source
