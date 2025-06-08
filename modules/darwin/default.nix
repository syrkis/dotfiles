{ pkgs, ... }: {
  programs.zsh.enable = true;
  system.primaryUser = "syrkis"; # Match the username you're using
  programs.fish.enable = true;
  environment.shells = with pkgs; [ zsh bash fish nushell ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  environment = {
    systemPackages = [ pkgs.coreutils pkgs.nushell ];
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

  # Homebrew configuration - works with nix-homebrew
  homebrew = {
    enable = true; # This is required for nix-darwin to manage packages!
    caskArgs.no_quarantine = true;
    global.brewfile = true;

    brews = [
      "pkg-config"
      "watch"
      "bfg"
      "fswatch"
      "pdf2svg"
      "cmake"
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
      "steam"
      "brave-browser"
      "slack"
      "zen-browser"
      "logseq"
      "raycast"
      "zed"
      "iterm2"
      "skim"
      "obs"
      "notunes"
      "vagrant"
      "spotify"
    ];
  };
}
