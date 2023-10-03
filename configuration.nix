{ config, pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  boot.kernelModules = [ "amdgpu" ];

  hardware = {
    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    enableAllFirmware = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  # Networking
  networking = {
    hostName = "mbrignall";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts =
        [ 22 80 443 5432 5672 ]; # SSH, HTTP, HTTPS, and PostgreSQL
    };
  };

  # systemd.services.NetworkManager-wait-online = {
  #   serviceConfig = {
  #     ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
  #   };
  # };

  # Set time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
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
  };

  console = {
    font = "ter-powerline-v28b";
    packages = [ pkgs.terminus_font pkgs.powerline-fonts ];
  };

  # Define user account.
  users.users.mbrignall = {
    isNormalUser = true;
    description = "Martin Brignall";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireless"
      "docker"
      "audio"
      "jackaudio"
      "libvirtd"
      "input"
      "disk"
      "kvm"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    alacritty
    bfcal
    blueberry
    brightnessctl
    btop
    clang
    cmake
    coreutils
    cups
    docker
    docker-compose
    emptty
    eww-wayland
    firefox
    exfat
    fuzzel
    fwupd
    gcc
    git
    gimp
    glib
    google-chrome
    graphviz
    grim
    sway-contrib.grimshot
    gnumake
    gtk3
    gtk-layer-shell
    ispell
    inetutils
    jdk17
    jq
    karlender
    labwc
    libnotify
    libtool
    mako
    maim
    multimarkdown
    imagemagick
    openjdk
    pandoc
    pavucontrol
    pipenv
    plantuml
    powerstat
    python3
    qemu
    ripgrep
    rnix-lsp
    sfwbar
    slack
    slurp
    swaybg
    swayidle
    swaylock
    swww
    syncthing
    tailscale
    terraform
    tigervnc
    udisks
    unzip
    vulkan-loader
    vim
    virt-manager
    vlc
    wayland
    wl-clipboard
    wdisplays
    wget
    wgnord
    xdg-utils
    yarn
  ];

  # Virtualisation
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  users.extraGroups.docker.members = [ "mbrignall" ];

  # Flakes setup
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.keep-outputs = true;
    settings.keep-derivations = true;
  };

  programs = {
    # Dconf
    dconf.enable = true;
    # Enable Sway.
    sway.enable = true;
    # Enable ZSH
    zsh.enable = true;
    # Enable Thunar
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {

    postgresql = {
      package = pkgs.postgresql_15;
      port = 5432;
      enable = true;
      enableTCPIP = true;
      ensureDatabases = [ "foyer-test" ];
      ensureUsers = [{ name = "foyer-app"; }];
      authentication = ''
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             0.0.0.0/0               trust
      '';
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    jack = {
      jackd.enable = true;
      # support ALSA only programs via ALSA JACK PCM plugin
      alsa.enable = false;
      # support ALSA only programs via loopback device
      loopback = { enable = true; };
    };

    # Enable Tailscale.
    tailscale.enable = true;

    # Disable the X11 window system.
    xserver.enable = false;

    # Enable Syncthing
    syncthing = {
      enable = true;
      user = "mbrignall";
      dataDir = "/home/mbrignall/org/";
      configDir = "/home/mbrignall/.config/syncthing";
    };

    # Enable the CUPS printing system.
    printing.enable = true;
    avahi.enable = true;
    avahi.nssmdns = true;
    # for a WiFi printer
    avahi.openFirewall = true;

    # Firmware updates
    fwupd.enable = true;

    gvfs.enable = true;
    tumbler.enable = true;

  };

  # General Updates
  system = {
    autoUpgrade.enable = true;
    stateVersion = "23.05";
  };

}
