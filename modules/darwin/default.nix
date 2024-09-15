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
    system.stateVersion = 4;
    homebrew = {
        enable = true;
        caskArgs.no_quarantine = true;
        global.brewfile = true;
        casks = [
            "beeper"
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
            "qutebrowser"
        ];
    };
}
