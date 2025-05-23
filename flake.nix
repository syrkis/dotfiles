{
    description = "learning nix";
    inputs  = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        fenix.url = "github:nix-community/fenix";
        darwin.url = "github:lnl7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
    };
    outputs = inputs : {
        darwinConfigurations.mac624172 = inputs.darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
            modules = [
                ./modules/darwin
                inputs.home-manager.darwinModules.home-manager
                {
                    users.users.nobr = {
                        name = "nobr";
                        home = "/Users/nobr";
                    };
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.nobr.imports = [ ./modules/home-manager ];
                        extraSpecialArgs = { inherit inputs; };
                    };
                }
            ];
        };
    };
}
