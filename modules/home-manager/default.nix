{ pkgs, ...}: {
    home.stateVersion = "24.11";
    home.packages = with pkgs; [
        (pass.withExtensions (ps: [ ps.pass-otp ]))
        ripgrep
        fd
        typescript
        nmap
        s3cmd
        nil
        hledger
        hledger-ui
        ledger-web
        asciinema
        colima  # vagrant vm stuff
        croc
        docker
        nixd
        curl
        biome
        starship
        wget
        less
        neovim
        fzf
        typst
        iterm2
        # gnupg1orig
        htop
        tealdeer
        ollama
        python311
        poetry
        todo
        cargo
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
        zoxide
        sd
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
