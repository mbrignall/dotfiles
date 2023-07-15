{ config, pkgs, ... }:

{
  home = {
    stateVersion = "23.05";
    username = "mbrignall";
    homeDirectory = "/home/mbrignall";
  };

  # programs.zsh = {
  #   enable = true;
  #   ohMyZsh.enable = true;
  #   ohMyZsh.theme = "powerlevel10k/powerlevel10k";
  #   ohMyZsh.plugins = [ "git" "docker" "nix" ];
  # };

  # Home Manager allows you to manage user-specific files
  # Here's an example that creates a symbolic link from the file
  # /home/mbrignall/.config to the file .config in your repository
  home.file.".config".source = ../.config;

  # Here's how you can set a shell option
  # programs.zsh.interactiveShellInit = ''
  #   # Example shell option
  #   setopt AUTO_CD
  # '';

  # Set packages
  home.packages = with pkgs; [
    alacritty
    bat
    bc
    bfcal
    blueberry
    brightnessctl
    clang
    cmake
    coreutils
    direnv
    docker
    docker-compose
    editorconfig-core-c
    emacs
    emptty
    eww-wayland
    fd
    font-awesome_5
    fuzzel
    gcc
    gsettings-desktop-schemas
    git
    gimp
    glib
    gnome3.adwaita-icon-theme
    google-chrome
    graphviz
    grim
    gvfs
    python311Packages.grip
    gnumake
    hugo
    imagemagick
    ispell
    jdk17
    jq
    nodePackages.js-beautify
    karlender
    libnotify
    libtool
    mako
    maim
    networkmanager-fortisslvpn
    ntfs3g
    exfat
    nixfmt
    nodejs
    oh-my-zsh
    pkgs.openai
    pandoc
    pavucontrol
    plantuml
    powerstat
    python39
    python39Packages.black
    python39Packages.pyflakes
    python39Packages.isort
    pipenv
    python39Packages.nose
    python39Packages.pytest
    python311Packages.weasyprint
    qemu
    ripgrep
    rnix-lsp
    shellcheck
    shfmt
    slack
    slurp
    nodePackages.stylelint
    swayidle
    swaylock
    terminus-nerdfont
    terraform
    html-tidy
    udisks
    usermount
    vim
    virt-manager
    vlc
    vulkan-loader
    waybar
    wayland
    wl-clipboard
    wdisplays
    wget
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    yarn
    zsh
  ];
}
