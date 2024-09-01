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
        python311
    ];
    programs = {
        bat.enable = true;
        git.enable = true;
        starship.enable = true;
        starship.enableZshIntegration = true;
        zsh.enable = true;
        alacritty.enable = true;
    };
}
