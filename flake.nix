{
    description = "learning nix";
    inputs  = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        fenix.url = "github:nix-community/fenix";
        darwin.url = "github:lnl7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli/nix-homebrew";

        # Declarative tap management
        homebrew-core = {
            url = "github:homebrew/homebrew-core";
            flake = false;
        };
        homebrew-cask = {
            url = "github:homebrew/homebrew-cask";
            flake = false;
        };
    };
    outputs = inputs : {
        darwinConfigurations.c23 = inputs.darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
            modules = [
                ./modules/darwin
                inputs.home-manager.darwinModules.home-manager
                inputs.nix-homebrew.darwinModules.nix-homebrew
                {
                    nix-homebrew = {
                        # Install Homebrew under the default prefix
                        enable = true;

                        # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                        enableRosetta = false;

                        # User owning the Homebrew prefix
                        user = "syrkis";

                        # Optional: Declarative tap management
                        taps = {
                            "homebrew/homebrew-core" = inputs.homebrew-core;
                            "homebrew/homebrew-cask" = inputs.homebrew-cask;
                        };

                        # Automatically migrate existing Homebrew installations
                        autoMigrate = true;

                        # Optional: Enable fully-declarative tap management
                        # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`
                        mutableTaps = false;
                    };
                    users.users.syrkis = {
                        name = "syrkis";
                        home = "/Users/syrkis";
                    };
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.syrkis.imports = [ ./modules/home-manager ];
                        extraSpecialArgs = { inherit inputs; };
                    };
                }
            ];
        };
    };
}
