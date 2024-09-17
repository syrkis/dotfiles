if status is-interactive
	# Commands to run in interactive sessions can go here
	set -gx EDITOR  vim
	zoxide init fish | source
	starship init fish | source
	alias ll='eza -lah --icons --octal-permissions'
	alias l='eza -lah --icons --octal-permissions'
	alias ls='eza --icons'
	alias cat='bat -p'
	alias cd='z'
end
