{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      custom = "${self}/home-manager/.oh-my-zsh";
    };
  };

  home.file = {
    ".zshrc".source = "${self}/home-manager/.zshrc";
    ".config".source = "${self}/.config";
    ".config".target = ".config";
  };

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
    grip
    gnumake
    hugo
    imagemagick
    ispell
    jdk17
    jq
    karlender
    libnotify
    libtool
    mako
    maim
    networkmanager-fortisslvpn
    ntfs3g
    exfat
    nixfmt
    pandoc
    pavucontrol
    plantuml
    powerstat
    qemu
    ripgrep
    rnix-lsp
    shellcheck
    shfmt
    slack
    slurp
    swayidle
    swaylock
    terminus-nerdfont
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

  programs.emacs = {
    enable = true;
    doomPrivateDir = "${self}/home-manager/doom.d";
    package = emacs-overlay.packages.${system}.emacsGcc;
  };

  home.activation.tangleDoomConfig = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    ${pkgs.emacs}/bin/emacs --batch --load ${pkgs.emacsPackages.doom-emacs}/core/cli.el --eval "(doom-tangle ${./path/to/README.org})"
  '';

  home.file.".doom.d".source = "${self}/home-manager/doom.d";
  home.file.".doom.d".recursive = true;
}
