{
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager/user.nix
    ../../home-manager/hyprland
  ];

  home.packages = with pkgs; [
    # Core applications
    nemo
    brightnessctl
    swaynotificationcenter
    libnotify
    hyprshot
    hyprsysteminfo
    pavucontrol
    networkmanagerapplet
    hyprshutdown
    hyprpolkitagent

    # Applications
    discord

    # Desktop environment

    # Utilities
    unzip

    # Programming
    tree-sitter
    clang
    vim
    ripgrep
    xclip
    rustup

    python314

    # Misc
    fastfetch
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      ff = "fastfetch";
    };
  };

  programs.btop.enable = true;
  programs.firefox.enable = true;
  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
    };
  };
}
