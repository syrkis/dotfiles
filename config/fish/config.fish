if status is-interactive
    # Commands to run in interactive sessions can go here

    # Add Homebrew directories to the PATH
    set -Ua fish_user_paths /opt/homebrew/bin /opt/homebrew/sbin

end
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/syrkis/.ghcup/bin $PATH # ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/syrkis/.ghcup/bin $PATH # ghcup-env
starship init fish | source

set -gx PATH /Users/syrkis/.local/bin $PATH
set -gx PATH /Applications/Julia-1.9.app/Contents/Resources/julia/bin $PATH

set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths


set -gx NILEARN_DATA ~/.cache/nilearn_data
set -gx TFDS_DATA_DIR ~/.cache/tensorflow_datasets

# neovim default editor
set -Ux EDITOR nvim


if not functions -q vi
    alias vi=nvim
    funcsave vi
end

if not functions -q vim
    alias vim=nvim
    funcsave vim
end

alias ls='eza'
alias l='eza -lh'

set -lx lines (cat ~/.env)
for line in $lines
    set -lx key (echo $line | cut -d '=' -f 1)
    set -lx value (echo $line | cut -d '=' -f 2-)
    set -gx $key $value
end

pyenv init - | source
eval "$(starship init fish)"
eval "$(starship init fish)"
