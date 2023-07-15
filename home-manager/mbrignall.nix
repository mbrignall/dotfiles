{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";

  outputs = { self, nixpkgs, home-manager, emacs-overlay }: {
    nixosConfigurations = {
      mbrignixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.mbrignall = import ./home-manager/mbrignall.nix;
          }
        ];
      };
    };
  };
}
