{ pkgs, ... }: {
  imports = [
    ../../home-manager/user.nix
    ../../home-manager/plasma.nix
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      ff = "fastfetch";
    };
  };

  home.packages = with pkgs; [
    firefox
    discord
    spotify
    thunderbird
    filezilla
    vlc
    obsidian
    prismlauncher
    libreoffice
    piper
    kdePackages.kalk
    kdePackages.filelight
    kdePackages.kiten
    kdePackages.zanshin
  ];
}
