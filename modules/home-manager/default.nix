{ pkgs, ...}: {
    home.stateVersion = "24.05";
    home.packages = with pkgs; [
        ripgrep
        fd
        curl
        less
        neovim
        fzf
        typst
        iterm2
        pass
        passExtensions.pass-otp
        tealdeer
        python311
        poetry
    ];
    programs = {
        bat.enable = true;
        git.enable = true;
        starship.enable = true;
        starship.enableZshIntegration = true;
        starship.enableFishIntegration = true;
        zsh.enable = true;
        alacritty.enable = true;
    };
}
