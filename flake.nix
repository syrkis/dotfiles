{
    description = "learning nix";

    inputs  = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        home-manager.url = "github:nix-community/home-manager/master";  # for config files
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        darwin.url = "github:lnl7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs : {
        darwinConfigurations.c24 = inputs.darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
            modules = [
                ({pkgs, ...}: {
                    programs.zsh.enable = true;
                    environment.shells = [ pkgs.zsh pkgs.bash ];  # enable multiple shells
                    environment.loginShell = pkgs.zsh;  # set zsh as the login shell
                    nix.extraOptions = ''
                        experimental-features = nix-command flakes
                    '';
                    environment.systemPackages = [ pkgs.coreutils ];
                    fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
                    services.nix-daemon.enable = true;
                    system.defaults.dock.autohide = true;
                    system.stateVersion = 4;
                })
                inputs.home-manager.darwinModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.nobr.imports = [
                            ({ pkgs, ...}: {
                                home.stateVersion = "22.11";
                                home.packages = with pkgs; [ ripgrep fd curl less ];

                                programs.bat.enable = true;
                                programs.git.enable = true;
                                programs.zsh.enable = true;
                            })
                        ];
                    };
                }
            ];
        };
    };
}
