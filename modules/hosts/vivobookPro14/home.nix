{
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager/hyprland
  ];

  home = {
    username = "kubamik2";
    homeDirectory = "/home/kubamik2";
    stateVersion = "26.05";
    packages = with pkgs; [
      # Core applications
      kdePackages.dolphin
      brightnessctl
      swaynotificationcenter
      libnotify
      hyprshot

      # Applications

      # Desktop environment
      # hyprlauncher

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
      # lua-language-server

      # Misc
      fastfetch
    ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      ff = "fastfetch";
    };
  };

  programs.btop.enable = true;
  programs.firefox.enable = true;
}
