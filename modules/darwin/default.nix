{pkgs, ...}: {
    programs.zsh.enable = true;
    programs.fish.enable = true;
    environment.shells = with pkgs; [ zsh bash fish ];
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
        brews = ["libffi" "pkg-config" "fswatch" "pdf2svg" "cmake" "freetype" "gettext" "gmp" "hiredis" "jpeg-turbo" "jsoncpp" "leveldb" "libogg" "libpng" "libvorbis" "luajit" "zstd" "gettext"];
        casks = [
            "spotify"
            "font-new-computer-modern"
            "freesurfer"
            "beeper"
            "steam"
            "arc"
            "raycast"
            "brave-browser"
            "slack"
            "libreoffice"
            "amethyst"
            "zed"
            "markedit"
            "skim"
            "obs"
            "utm"
            "warp"
            "notunes"
            "obsidian"
            "vagrant"
            "protonvpn"
        ];
    };
}
