{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    in rec {
      # # Your custom packages
      # # Acessible through 'nix build', 'nix shell', etc
      # packages = forAllSystems (system:
      #   let pkgs = nixpkgs.legacyPackages.${system};
      #   in import ./pkgs { inherit pkgs; }
      # );
      # # Devshell for bootstrapping
      # # Acessible through 'nix develop' or 'nix-shell' (legacy)
      # devShells = forAllSystems (system:
      #   let pkgs = nixpkgs.legacyPackages.${system};
      #   in import ./shell.nix { inherit pkgs; }
      # );

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # FIXME replace with your hostname
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./configuration.nix
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # FIXME replace with your username@hostname
        "mbrignall@mbrignall" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main home-manager configuration file <
            ./home-manager/home.nix
          ];
        };
      };
    };
}
