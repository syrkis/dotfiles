# dotfiles

- Ensure that the username and computer name is correct in `flake.nix`, and then:
  - `sh <(curl -L https://nixos.org/nix/install)`
  - `sudo ln -s ~/desk/dotfiles /etc/nix-darwin`
  - `nix run nix-darwin/master#darwin-rebuild --extra-experimental-features nix-command --extra-experimental-features flakes -- switch`
  - `darwin-rebuild switch` can then be run to update. Maybe run `nix flake update` as well. not sure.

## iTerm2 emergency config

- Open iTerm2 Preferences (Command + ,).
  - Go to Profiles > Keys and click "Create a Dedicated Hotkey Window".
- Set your desired hotkey combination.
- In the same dialog, enable the following options:
- "Pin hotkey window (stays open on loss of keyboard focus)"
- "Floating window"
- Go to Profiles > Window and set "Space" to "All Spaces".
- In Preferences > Advanced, set "Hide iTerm2 from the dock" to Yes.
