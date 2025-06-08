{ pkgs, inputs, ... }: {
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    inputs.fenix.packages.${pkgs.system}.stable.toolchain
    uiua
    nushell
    uv
    blender
    (pass.withExtensions (ps: [ ps.pass-otp ]))
    ripgrep
    fd
    zoxide
    typescript
    nixpkgs-fmt
    imagemagick
    ghostscript
    nmap
    clojure
    nil
    hledger
    newcomputermodern
    hledger-ui
    asciinema
    croc
    docker
    nixd
    curl
    biome
    starship
    wget
    less
    pandoc
    # neovim
    fzf
    typst
    iterm2
    htop
    tealdeer
    ollama
    # poetry
    # todo
    eza
    ffmpeg
    swig4
    just
    typstyle
    # pyenv
    hurl
    # tinymist
    himalaya
    nodejs_22
    nixfmt
    zoxide
    sd
  ];
  programs = {
    bat.enable = true;
    git = {
      enable = true;
      userName = "Noah Syrkis";
      userEmail = "noah@syrkis.com";
      signing = {
        key = null; # Set to your signing key if you want to sign commits
        signByDefault = false;
        format = "ssh"; # or "gpg" depending on your preference
      };
    };
    starship.enable = true;
    zellij.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        # Himalaya email client
        {
          plugin = himalaya-vim;
          config = ''
            " Himalaya configuration
            syntax on
            filetype plugin on
            set hidden

            " Optional: set folder picker (telescope, fzf, fzflua, or native)
            let g:himalaya_folder_picker = 'telescope'

            " Optional: enable telescope preview
            let g:himalaya_folder_picker_telescope_preview = 1
          '';
        }

        # Recommended plugins for better experience
        telescope-nvim
        plenary-nvim # Required by telescope
        fzf-vim
      ];

      extraConfig = ''
        " General Neovim settings
        syntax on
        filetype plugin on
        set hidden
      '';
    };
    alacritty = { enable = true; };
  };
}
