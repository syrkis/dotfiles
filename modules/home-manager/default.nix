{ pkgs, ...}: {
    home.stateVersion = "24.11";
    home.packages = with pkgs; [
        (pass.withExtensions (ps: [ ps.pass-otp ]))
        ripgrep
        fd
        lima # docker alternative
        colima  # vagrant vm stuff
        croc
        docker
        netlify-cli
        curl
        starship
        wget
        less
        neovim
        fzf
        typst
        iterm2
        gnupg1orig
        htop
        # pass
        pandoc
        tealdeer
        ollama
        python311
        poetry
        todo
        cargo
        uiua
        eza
        ffmpeg
        swig4
        wakatime
        just
        typstyle
        hurl
        tinymist
        himalaya
        ruff
        nodejs_20
        racket
        zoxide
        nushell
        sd
        # nmap
        # texlive
    ];
    programs = {
        bat.enable = true;
        git.enable = true;
        starship.enable = true;
        zellij.enable = true;
        alacritty = {
            enable = true;
        };
        # nixvim = {
            # enable = true;
            # colorschemes.catppuccin.enable = true;
            # plugins.lualine.enable = true;
        # };
    };
}
