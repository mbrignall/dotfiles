{ config, pkgs, ... }:

{

  imports = [
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "mbrignall";
    homeDirectory = "/home/mbrignall";
    stateVersion = "23.05";
    packages = with pkgs; [

      #paclages
      bat
      bc
      nix-direnv
      fd
      grim
      sway-contrib.grimshot
      htop
      slurp
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
        fonts = [
          "FiraCode"
          "FiraMono"
          "Hack"
          "DroidSansMono"
          "Meslo"
        ];
      })
    ];
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself
  programs = {
    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # ZSH config, including aliases, p10k pkgs.
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      doomrestart = "bash ~/.config/home-manager/dotfiles/doomrestart";
      g = "git";
      gs = "git status";
      update = "sudo nixos-rebuild switch";
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

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3.extraCss = "decoration, decoration:backdrop {box-shadow: none;}\n
                     .titlebar, .titlebar .background,\n
                     decoration, window, window.background\n
                     {border-radius: 0; font-family: FiraMono Nerd Font;}";

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
