{ lib, pkgs, nixpkgs, ... }:
let p10kTheme = ./.config/.p10k.zsh;
in {

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
      ".config/mako/config".source = .config/mako/config;
      ".config/swappy/config".source = .config/swappy/config;
      ".config/swaylock/config".source = .config/swaylock/config;
      ".config/waybar/config.jsonc".source = .config/waybar/config.jsonc;
      ".config/waybar/rose-pine-dawn.css".source =
        .config/waybar/rose-pine-dawn.css;
      ".config/waybar/style.css".source = .config/waybar/style.css;
      ".config/waybar/scripts/mediaplayer.py".source =
        .config/waybar/scripts/mediaplayer.py;
    };

    packages = with pkgs; [

      #packages
      bat
      bc
      black
      ditaa
      editorconfig-core-c
      nix-direnv
      fd
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
      nodePackages.vscode-html-languageserver-bin
      nyxt
      p7zip
      playerctl
      qmk
      remmina
      rpi-imager
      ruff
      shellcheck
      shfmt

      tree-sitter
      vscode-extensions.github.copilot
      yamlfmt
      zsh
      zsh-powerlevel10k
      postgresql

      grim
      hyprpicker
      slurp
      swappy
      waybar
      wl-clipboard

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
      '';
      enableAutosuggestions = true;
      shellAliases = {
        g = "git";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gp = "git push";
        gs = "git status";

        # Productivity

        l = "ls -alh";
        ll = "ls -l";
        ls = "ls -la --color=tty";

        cat = "bat";
        ccat = "bat --color=always";

        # Nix Build
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
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 16;
    };
  };

}
