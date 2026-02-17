{
  description = "Home Manager configuration of nstroffo";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixGL, ... }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ nixGL.overlay ];
    };
  in {
    homeConfigurations = {
      "nstroffo-home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit nixGL;
        };

        modules = [ ./home.nix ];
      };
    };
  };
}
