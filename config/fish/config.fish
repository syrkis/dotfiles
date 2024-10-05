if status is-interactive
	# Commands to run in interactive sessions can go here
	set -gx EDITOR  vim
	   set -x DOCKER_HOST unix:///Users/nobr/.colima/default/docker.sock
	zoxide init fish | source
	starship init fish | source
	alias ll='eza -lah --icons --octal-permissions'
	alias la='eza -ah --icons'
	alias l='eza -lh --icons'
	alias ls='eza --icons'
	alias cat='bat -p'
	alias cd='z'
	   source ~/.api_keys.fish
end
