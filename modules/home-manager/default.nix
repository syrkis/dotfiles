{ pkgs, ...}: {
    home.stateVersion = "25.05";
    home.packages = with pkgs; [
        (pass.withExtensions (ps: [ ps.pass-otp ]))
        ripgrep
        fd
        typescript
        nmap
        clojure
        s3cmd
        nil
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
        # tinymist
        himalaya
        ruff
        nodejs_20
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
                            key = null;  # Set to your signing key if you want to sign commits
                            signByDefault = false;
                            format = "ssh";  # or "gpg" depending on your preference
                        };
        };
        starship.enable = true;
        zellij.enable = true;
        alacritty = {
            enable = true;
        };
    };
}
