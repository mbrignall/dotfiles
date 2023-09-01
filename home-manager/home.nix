{ config, pkgs, ... }:

{

  imports = [ ];

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
        ./.config/alacritty/alacritty.yml;
      # ".emacs.d/init.el".source = ../.config/emacs/init.el;
      # ".emacs.d/custom.el".source = ../.config/emacs/custom.el;
      ".config/fuzzel/fuzzel.ini".source = ./.config/fuzzel/fuzzel.ini;
      # ".config/home-manager/home.nix".source = ../home-manager/home.nix;
      # ".config/mako/config".source = ../.config/mako/config;
      # ".config/hypr/hyprland.conf".source = ../.config/hypr/hyprland.conf;
      # ".config/hypr/hyprpaper.conf".source = ../.config/hypr/hyprpaper.conf;
      # ".config/sway/config".source = ../.config/sway/config;
      # ".config/swaylock/config".source = ../.config/swaylock/config;
      # ".config/waybar/config".source = ../.config/waybar/config;
      # ".config/waybar/style.css".source = ../.config/waybar/style.css;
    };

    packages = with pkgs; [

      #packages
      bat
      bc
      nix-direnv
      fd
      grim
      inkscape-with-extensions
      sway-contrib.grimshot
      htop
      slurp
      swappy
      zsh
      zsh-powerlevel10k

      #fonts
      fira-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
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
      enableAutosuggestions = true;
      shellAliases = {
        g = "git";
        gs = "git status";
        update =
          "sudo nixos-rebuild switch --flake .#mbrignall && home-manager switch --flake .#mbrignall";
      };
      plugins = with pkgs; [
        {
          file = "powerlevel10k.zsh-theme";
          name = "powerlevel10k";
          src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
        }
        {
          file = ".p10k.zsh";
          name = "powerlevel10k-config";
          src = "/home/mbrignall/dotfiles/.config/";
        }
      ];
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
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 18;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3.extraCss = ''
      decoration, decoration:backdrop {box-shadow: none;}

                           .titlebar, .titlebar .background,

                           decoration, window, window.background

                           {border-radius: 0; font-family: FiraMono Nerd Font;}'';

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
