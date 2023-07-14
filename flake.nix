{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      mbrignixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.mbrignall
          home-manager.nixosModules.home-manager
          {
            home-manager.users.mbrignall = import ./home-manager/mbrignall.nix;
          }
        ];
      };
    };

    nixosModules.mbrignall = { config, pkgs, ... }: {
      imports = [
        /etc/nixos/hardware-configuration.nix
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot/efi";
      boot.kernelModules = [ "amdgpu" ];
      hardware.opengl.driSupport32Bit = true;
      hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      hardware.enableAllFirmware = true;
      networking.hostName = "nixos";
      networking.networkmanager.enable = true;
      time.timeZone = "Europe/London";
      i18n.defaultLocale = "en_GB.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };

      console = {
        packages = [ pkgs.terminus_font ];
        font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
        useXkbConfig = true;
      };

      sound.enable = true;
      hardware.pulseaudio.enable = false;
      hardware.bluetooth.enable = true;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.users.mbrignall = {
        isNormalUser = true;
        description = "Martin Brignall";
        extraGroups = [
          "networkmanager"
          "wheel"
          "wireless"
          "docker"
          "audio"
          "libvirtd"
          "input"
          "disk"
          "kvm"
        ];
        shell = pkgs.zsh;
        packages = with pkgs; [ google-chrome ];
      };

      users.extraGroups.docker.members = [ "mbrignall" ];
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [ ];
      nixpkgs.overlays = [
        (import (builtins.fetchTarball
          "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz"))
      ];

      fonts = {
        fonts = with pkgs; [
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          font-awesome
          (nerdfonts.override {
            fonts = [ "FiraCode" "FiraMono" "Hack" "DroidSansMono" "Meslo" ];
          })
        ];
      };

      services.xserver.enable = false;
      services.flatpak.enable = true;
      virtualisation.libvirtd.enable = true;
      programs.dconf.enable = true;
      virtualisation.docker.enable = true;

      nix = {
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
      };

      programs.sway.enable = true;
      programs.hyprland.enable = true;
      programs.zsh.enable = true;

      system.autoUpgrade.enable = true;
      system.stateVersion = "23.05";
    };
  };
}
