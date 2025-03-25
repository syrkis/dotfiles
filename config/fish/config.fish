if status is-interactive
    # Commands to run in interactive sessions can go here
    # set -gx EDITOR  vim
    set -gx EDITOR "zed --wait"

    set -x DOCKER_HOST unix:///Users/nobr/.colima/default/docker.sock
    set -x PATH $HOME/.npm-global/bin $PATH
    set -gx PATH $PATH /Users/nobr/.juliaup/bin
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

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/nobr/.lmstudio/bin

pyenv init - fish | source
