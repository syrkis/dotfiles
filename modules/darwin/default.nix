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
    fonts.packages = [ pkgs.nerd-fonts.fira-code ];
    services.nix-daemon.enable = true;
    system.defaults.dock.autohide = true;
    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;
    system.stateVersion = 4;
    homebrew = {
        enable = true;
        caskArgs.no_quarantine = true;
        global.brewfile = true;
        brews = [
          "libffi"
          "pkg-config"
          "fswatch"
          "pdf2svg"
          "cmake"
          "freetype"
          "gettext"
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
          # "pandoc"
        ];
        casks = [
            "spotify"
            "freesurfer"
            "beeper"
            "steam"
            "arc"
            "brave-browser"
            "slack"
            "markedit"
            "skim"
            "obs"
            "utm"
            "notunes"
            "obsidian"
            "vagrant"
            "protonvpn"
            "whatsapp"
            "lm-studio"
        ];
    };
}
