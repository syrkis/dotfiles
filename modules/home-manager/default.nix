{ pkgs, ...}: {
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
        ripgrep
        fd
        curl
        wget
        less
        neovim
        fzf
        typst
        iterm2
        gnupg1orig
        htop
        pass
        tealdeer
        ollama
        python311
        # python311Packages.pip
        python311Packages.ipykernel
        # python311Packages.notebook
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
        tinymist
        himalaya
        ruff
    ];
    programs = {
        bat.enable = true;
        git.enable = true;
        starship.enable = true;
        starship.enableZshIntegration = true;
        starship.enableFishIntegration = true;
        zellij.enable = true;
        alacritty.enable = true;
    };
}
