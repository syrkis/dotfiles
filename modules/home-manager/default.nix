{ pkgs, inputs, ...}: {
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
        # Rust toolchain from Fenix
        inputs.fenix.packages.${pkgs.system}.stable.toolchain

        # Uiua language
        uiua

        # uv instead of poetry
        uv


        blender
        (pass.withExtensions (ps: [ ps.pass-otp ]))
        ripgrep
        fd
        typescript
        imagemagick
        ghostscript
        nmap
        clojure
        # s3cmd
        # zed-editor
        nil
        hledger
        newcomputermodern
        hledger-ui
        asciinema
        # colima
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
        ruff
        nodejs_22
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
