{ config, pkgs, ... }:

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

  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  hardware.enableAllFirmware = true;

  # Networking
  networking = {
    hostName = "mbrignall";
    networkmanager.enable = true;
  };

  # Set time zone.
  time.timeZone = "Europe/London";

  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };

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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth = { enable = true; };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
    clang
    cmake
    coreutils
    cups
    direnv
    ditaa
    docker
    docker-compose
    editorconfig-core-c
    emptty
    eww-wayland
    exfat
    font-awesome_5
    fuzzel
    gcc
    git
    gimp
    glib
    google-chrome
    graphviz
    grim
    gvfs
    gsettings-desktop-schemas
    gnumake
    gtk3
    hugo
    html-tidy
    ispell
    jdk17
    jq
    karlender
    libnotify
    libtool
    mako
    maim
    multimarkdown
    imagemagick
    networkmanager-fortisslvpn
    nixfmt
    nodejs
    nodePackages.js-beautify
    nodePackages.pyright
    nodePackages.stylelint
    nodePackages.vscode-langservers-extracted
    ntfs3g
    openjdk
    usermount
    pandoc
    pavucontrol
    pipenv
    plantuml
    powerstat
    python3
    qemu
    ripgrep
    rnix-lsp
    shellcheck
    shfmt
    slack
    slurp
    swayidle
    swaylock
    syncthing
    tailscale
    terminus-nerdfont
    terraform
    tree-sitter
    udisks
    unzip
    vulkan-loader
    vim
    virt-manager
    vlc
    vscode-extensions.github.copilot
    waybar
    wayland
    wl-clipboard
    wdisplays
    wget
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    yarn
  ];

  ## Services
  services = {
    tailscale.enable = true;
    # Disable the X11 window system.
    xserver.enable = false;
    # Enable Flatpak
    flatpak.enable = true;
  };

  services.syncthing = {
    enable = true;
    user = "mbrignall";
    dataDir = "/home/mbrignall/org/";
    configDir = "/home/mbrignall/.config/syncthing";
  };

  # Virtualisation
  virtualisation = {
    libvirtd.enable = true;
    # Dconf/Edit GTK apps
    # Docker virtualisation
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
    # Enable Sway.
    dconf.enable = true;
    sway.enable = true;
    # Enable Hyprland
    hyprland.enable = true;
    # Enable ZSH
    zsh.enable = true;
    # If you want to use waybar as your swaybar
    waybar.enable = true;
  };

  # updates
  system = {
    autoUpgrade.enable = true;
    stateVersion = "23.05";
  };
}
