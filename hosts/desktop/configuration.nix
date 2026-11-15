{
  pkgs,
  config,
  agenixRegistry,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./wakeupFix.nix
    ../../modules/default.nix
  ];

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
      eza.enable = true;
      agenix = {
        enable = true;
        enabledKeys = [
          "github"
          "rpi4NixSigningKey"
          "rpi4SSH"
        ];
      };
    };
    profiles = {
      gaming.enable = true;
      printing = {
        enable = true;
        brother.enable = true;
      };
      servers.rpi4.enable = true;
    };
  };

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ]; # Mainly used for building derivations for rpi4
  };

  # Nix signing keys
  nix.settings.secret-key-files = [ config.age.secrets.rpi4NixSigningKey.path ];

  # Networking
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  # Time zone
  time.timeZone = "Europe/Warsaw";

  # Input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [
      pkgs.fcitx5-mozc
    ];
  };

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

  # Needed for Keychron Launcher
  services.udev.packages = [ pkgs.keychron-udev-rules ];

  # Packages
  environment.systemPackages = with pkgs; [
    # Development
    alacritty
    filezilla
    tmux
    arduino-ide

    # Gaming
    prismlauncher

    # Graphics
    gimp
    freecad
    orca-slicer

    # Multimedia
    easyeffects
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
    stow
  ];

  # Programs
  programs = {
    direnv.enable = true;
    nix-ld = {
      enable = true;
      libraries = [
        (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
        config.boot.kernelPackages.nvidia_x11
      ];
    };
  };

  # SSH config
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host github.com
        HostName github.com
        User kubamik2
        AddKeysToAgent 60m
        IdentityFile ${config.age.secrets.github.path}
        IdentitiesOnly yes
    '';
  };

  # Environment
  environment = {
    sessionVariables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      NIXOS_OZONE_WL = "1";
      HISTCONTROL = "ignoreboth:erasedups";
    };
    shellAliases.gh-add-key = "ssh-add ~/.ssh/github";
  };

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
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Do not change
  system.stateVersion = "25.11";
}
