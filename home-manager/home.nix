{ config, pkgs, nixpkgs, ... }:
let p10kTheme = ./.config/.p10k.zsh;
in {

  imports = [ ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home = {
    username = "mbrignall";
    homeDirectory = "/home/mbrignall";
    stateVersion = "23.05";
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 18;
    };

    file = {
      ".config/alacritty/alacritty.yml".source =
        .config/alacritty/alacritty.yml;
      ".config/fuzzel/fuzzel.ini".source = .config/fuzzel/fuzzel.ini;
      ".config/home-manager/home.nix".source = ../home-manager/home.nix;
      ".config/mako/config".source = .config/mako/config;
      ".config/hypr/hyprland.conf".source = .config/hypr/hyprland.conf;
      # ".config/sway/config".source = .config/sway/config;
      ".config/swaylock/config".source = .config/swaylock/config;
      ".config/waybar/config".source = .config/waybar/config;
      ".config/waybar/style.css".source = .config/waybar/style.css;
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
      inkscape-with-extensions
      jq
      nix-direnv
      nixfmt
      nodejs
      nodePackages.prettier
      nodePackages.js-beautify
      nodePackages.pyright
      nodePackages.stylelint
      nodePackages.vscode-langservers-extracted
      shellcheck
      shfmt
      slurp
      swappy
      tree-sitter
      vscode-extensions.github.copilot
      zsh
      zsh-powerlevel10k

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
        fonts = [ "FiraCode" "FiraMono" "Hack" "DroidSansMono" "Meslo" ];
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
      '';
      enableAutosuggestions = true;
      shellAliases = {
        g = "git";
        gs = "git status";
        update =
          "sudo nixos-rebuild switch --flake .#mbrignall && home-manager switch --flake .#mbrignall@mbrignall";
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

  nixpkgs = {
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
  };

  # GTK theme and dark mode preferences
  gtk = {
    enable = true;

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita-Dark";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 18;
    };

    gtk3.extraCss = ''
      decoration, decoration:backdrop {box-shadow: none;}

                           .titlebar, .titlebar .background,

                           decoration, window, window.background

                           {border-radius: 0; font-family: FiraMono Nerd Font;}'';

  };
}
