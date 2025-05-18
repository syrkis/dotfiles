if status is-interactive
    # Commands to run in interactive sessions can go here
    # set -gx EDITOR  vim
    # set -gx EDITOR "vim"

    set -x DOCKER_HOST unix:///Users/nobr/.colima/default/docker.sock
    set -x PATH $HOME/.npm-global/bin $PATH
    # Add Rustup to PATH - make sure this comes before other Homebrew paths
    # set -gx PATH "$(brew --prefix rustup)/bin" $PATH
    set -gx PATH $PATH /Users/nobr/.juliaup/bin

    set -gx PKG_CONFIG_PATH /opt/homebrew/opt/libffi/lib/pkgconfig
    set -gx DYLD_LIBRARY_PATH /opt/homebrew/opt/libffi/lib:$DYLD_LIBRARY_PATH
    set -gx LIBRARY_PATH /opt/homebrew/opt/libffi/lib:$LIBRARY_PATH

    # set -gx UIUA_ENABLE_SIXEL 1

    zoxide init fish | source
    starship init fish | source
    alias ll='eza -lah --icons --octal-permissions'
    alias la='eza -ah --icons'
    alias l='eza -lh --icons'
    alias ls='eza --icons'
    alias cat='bat -p'
    alias cd='z'
end
