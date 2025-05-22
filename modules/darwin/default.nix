{pkgs, ...}: {
    programs.zsh.enable = true;
    system.primaryUser = "nobr";  # Match the username you're using
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
    fonts.packages = [ pkgs.nerd-fonts.fira-code ];
    # services.nix-daemon.enable = true;
    ids.gids.nixbld = 350;
    system.defaults.dock.autohide = true;
    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;
    system.stateVersion = 4;
    homebrew = {
        enable = true;
        caskArgs.no_quarantine = true;
        global.brewfile = true;
        brews = [
            "pkg-config"
            "watch"
            "bfg"
            "fswatch"
            "pdf2svg"
            "cmake"
            "freetype"
            "gettext"
            "wakatime-cli"
            "gmp"
            "hiredis"
            "jpeg-turbo"
            "jsoncpp"
            "leveldb"
            "libogg"
            "libpng"
            "libvorbis"
            "luajit"
            "zstd"
            "gettext"
            "tinymist"
        ];
        casks = [
            "freesurfer"
            "steam"
            "arc"
            "psst"
            "brave-browser"
            "slack"
            "logseq"
            "tuta-mail"
            "raycast"
            "zed"
            "markedit"
            "skim"
            "obs"
            "utm"
            "notunes"
            "vagrant"
            "protonvpn"
            "whatsapp"
        ];
    };
}
