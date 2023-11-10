{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "benny";
    homeDirectory = "/home/benny";
  };

  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set the desktop wallpaper
  dconf.settings = {
    "org/gnome/desktop/background" = {
      "picture-uri" = "/home/benny/.background-image";
    };
    "org/gnome/desktop/screensaver" = {
      "picture-uri" = "/home/benny/.background-image";
    };
  };
  home.file.".background-image".source = /home/benny/Pictures/desktop-wallpaper.jpg;

  home.packages = with pkgs; [
    packer
    slack
    steam
    terraform
    tmux
    vagrant
    wireguard-tools
  ];

  programs = {
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      theme = "Argonaut";
      extraConfig = ''
        background_opacity 0.8
      '';
      font = {
        size = 12.0;
        name = "Terminus";
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["terraform" "tmux"];
        theme = "xiong-chiamiov-plus";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
