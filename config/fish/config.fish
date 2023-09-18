if status is-interactive
    # Commands to run in interactive sessions can go here

    # Add Homebrew directories to the PATH
    set -Ua fish_user_paths /opt/homebrew/bin /opt/homebrew/sbin
    
    # Add Python to path
    pyenv init - | source
end
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/syrkis/.ghcup/bin $PATH # ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/syrkis/.ghcup/bin $PATH # ghcup-env
starship init fish | source

set -gx PATH /Users/syrkis/.local/bin $PATH
set -gx PATH /Applications/Julia-1.9.app/Contents/Resources/julia/bin $PATH

if status is-interactive
   and not set -q TMUX
   exec tmux
end
