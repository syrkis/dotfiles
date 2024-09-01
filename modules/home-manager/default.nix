{ pkgs, ...}: {
    home.stateVersion = "22.11";
    home.packages = with pkgs; [
        ripgrep
        fd
        curl
        less
        neovim
        git
        bat
        fzf
    ];
    programs.bat.enable = true;
    programs.git.enable = true;
    programs.zsh.enable = true;

}
