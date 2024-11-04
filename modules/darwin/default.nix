{pkgs, ...}: {
    programs.zsh.enable = true;
    programs.fish.enable = true;
    environment.shells = with pkgs; [ zsh bash fish ];
    environment.loginShell = pkgs.zsh;
    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
    environment = {
        systemPackages = [ pkgs.coreutils ];
        systemPath = [ "/opt/homebrew/bin/" ];
        pathsToLink = [ "/Applications" ];
    };
    fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
    services.nix-daemon.enable = true;
    system.defaults.dock.autohide = true;
    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;
    system.stateVersion = 4;
    homebrew = {
        enable = true;
        caskArgs.no_quarantine = true;
        global.brewfile = true;
        brews = ["cairo"];
        casks = [
            "beeper"
            "steam"
            "raycast"
            "brave-browser"
            "slack"
            "amethyst"
            "zed"
            "markedit"
            "skim"
            "obs"
            "utm"
            "julia"
            "zettlr"
            "notunes"
            "obsidian"
            "vagrant"
            "orion"
            "protonvpn"
        ];
    };
}
