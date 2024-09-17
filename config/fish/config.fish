if status is-interactive
	# Commands to run in interactive sessions can go here
	set -gx EDITOR  vim
	starship init fish | source
	alias ll='eza -lah --icons --octal-permissions'
	alias l='eza -lah --icons --octal-permissions'
	alias ls='eza --icons'
end
