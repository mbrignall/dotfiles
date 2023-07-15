{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      custom = "./home-manager/.oh-my-zsh";
    };
  };

  home.file = {
    ".zshrc".source = "./home-manager/.zshrc";
    ".config".source = "./.config";
    ".config".target = ".config";
  };

  programs.emacs = {
    enable = true;
    doomPrivateDir = "./home-manager/doom.d";
    package = emacs-overlay.packages.${system}.emacsGcc;
  };
}
