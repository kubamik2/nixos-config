{
  pkgs,
  agenixRegistry,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ../../modules/default.nix
  ];

  modules = {
    core.enable = true;
    programs = {
      nh.enable = true;
      eza.enable = true;
    };
  };

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  networking = {
    hostName = "nixos-rpi4";
    networkmanager.enable = true;
    interfaces.wlan0 = {
      ipv4.addresses = [{
        address = "192.168.33.122";
        prefixLength = 24;
      }];
    };
    defaultGateway = {
      address = "192.168.33.1";
      interface = "wlan0";
    };
  };

  # Time zone
  time.timeZone = "Europe/Warsaw";

  # User
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [ agenixRegistry.keys.rpi4SSH.public ];
  };
  nix.settings.trusted-public-keys = [ agenixRegistry.keys.rpi4NixSigningKey.public ];

  # OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Do not change
  system.stateVersion = "26.05";
}
