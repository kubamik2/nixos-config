{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../modules/default.nix
  ];

  # Modules
  modules = {
    core.enable = true;
    desktop = {
      plasma.enable = true;
    };
    programs = {
      nh.enable = true;
      piper.enable = true;
      pipewire.enable = true;
      neovim.enable = true;
    };
    profiles = {
      printing.enable = true;
    };
  };

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking
  networking = {
    hostName = "nixos-laptop";
    networkmanager.enable = true;
  };

  # Time zone
  time.timeZone = "Europe/Warsaw";

  # User
  users.users.kubamik2 = {
    isNormalUser = true;
    description = "Jakub Mikuta";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    packages = [ ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    # Development
    alacritty
    filezilla
    tmux
    arduino-ide
    jetbrains.idea
    openjdk25
    uv
    vscodium

    # Graphics
    gimp

    # Multimedia
    spotify
    vlc

    # Internet
    discord
    firefox
    thunderbird

    # Office
    libreoffice
    obsidian

    # Utilities
    kdePackages.zanshin
    keepassxc
    piper
    eza
  ];

  # Programs
  programs = {
    ssh.startAgent = true;
    nix-ld = {
      enable = true;
      libraries = [
        (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
        config.boot.kernelPackages.nvidia_x11
      ];
    };
  };

  # Environment
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      HISTCONTROL = "ignoreboth:erasedups";
    };
    shellAliases = {
      ls = "eza";
    };
  };

  # Power profiles
  services.power-profiles-daemon.enable = true;

  # GPU drivers
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    open = true;
    nvidiaSettings = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Do not change
  system.stateVersion = "25.11";
}
