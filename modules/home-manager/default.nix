{ pkgs, ...}: {
    home.stateVersion = "25.05";
    home.packages = with pkgs; [
        (pass.withExtensions (ps: [ ps.pass-otp ]))
        ripgrep
        fd
        typescript
        nmap
        s3cmd
        nil
       	zed-editor
        hledger
        newcomputermodern
        hledger-ui
        asciinema
        colima
        croc
        docker
        nixd
        curl
        biome
        starship
        wget
        less
        pandoc
        neovim
        fzf
        typst
        raycast
        iterm2
        htop
        tealdeer
        ollama
        poetry
        todo
        cargo
        eza
        ffmpeg
        swig4
        just
        typstyle
        pyenv
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
    };
}
