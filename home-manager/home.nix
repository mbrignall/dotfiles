{ config, pkgs, nixpkgs, ... }:
let p10kTheme = ./.config/.p10k.zsh;

in {

  imports = [ ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "mbrignall";
    homeDirectory = "/home/mbrignall";
    stateVersion = "23.05";
    sessionVariables.GTK_THEME = "rose-pine-dawn";

    file = {
      ".config/alacritty/alacritty.yml".source =
        .config/alacritty/alacritty.yml;
      ".config/fuzzel/fuzzel.ini".source = .config/fuzzel/fuzzel.ini;
      ".config/labwc/autostart".source = .config/labwc/autostart;
      ".config/labwc/environment".source = .config/labwc/environment;
      ".config/labwc/menu.xml".source = .config/labwc/menu.xml;
      ".config/labwc/rc.xml".source = .config/labwc/rc.xml;
      ".config/labwc/scripts/grim".source = .config/labwc/scripts/grim;
      ".config/mako/config".source = .config/mako/config;
      ".config/swaylock/config".source = .config/swaylock/config;
      ".config/yambar/config.yml".source = .config/yambar/config.yml;
    };

    packages = with pkgs; [

      #packages
      bat
      bc
      ditaa
      editorconfig-core-c
      nix-direnv
      fd
      grim
      hugo
      html-tidy
      hyprpicker
      inkscape-with-extensions
      jq
      ncspot
      nix-direnv
      nixfmt
      nodejs
      nodePackages.prettier
      nodePackages.js-beautify
      nodePackages.pyright
      nodePackages.stylelint
      nodePackages.vscode-langservers-extracted
      p7zip
      remmina
      rpi-imager
      shellcheck
      shfmt
      slurp
      swappy
      tree-sitter
      vscode-extensions.github.copilot
      yambar
      yamlfmt
      zsh
      zsh-powerlevel10k
      postgresql

      #fonts
      fira-mono
      font-awesome
      font-awesome_5
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      terminus-nerdfont
      victor-mono
      (nerdfonts.override {
        fonts =
          [ "FiraCode" "FiraMono" "Hack" "DroidSansMono" "Meslo" "RobotoMono" ];
      })
    ];
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself
  programs = {

    home-manager.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      #extraConfig = builtins.readFile ./emacs-config.el;
    };

    zsh = {
      enable = true;
      initExtra = ''
          [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
        # '';
      enableAutosuggestions = true;
      shellAliases = {
        g = "git";
        gs = "git status";
        build =
          "sudo nixos-rebuild switch --flake ~/dotfiles/#mbrignall && home-manager switch --flake ~/dotfiles/#mbrignall@mbrignall";
        update = "sudo nix flake update && build";
        clean =
          "sudo nix-env --delete-generations old -p /nix/var/nix/profiles/system && sudo nix-collect-garbage -d && build";
      };

      plugins = with pkgs; [{
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }];
    };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "rose-pine-dawn";
      package = pkgs.rose-pine-icon-theme;
    };

    theme = {
      name = "rose-pine-dawn";
      package = pkgs.rose-pine-gtk-theme;
    };

    cursorTheme = {
      name = "Quintom";
      package = pkgs.quintom-cursor-theme;
    };
  };

}
