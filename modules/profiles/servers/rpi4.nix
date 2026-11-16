{
  config,
  helpers,
  agenixRegistry,
  ...
}:
helpers.mkOptionalModule config {
  path = "profiles.servers.rpi4";
  description = "Raspberry Pi 4 server profile";
  moduleConfig = {
    # Agenix config
    modules.programs.agenix = {
      enable = true;
      enabledKeys = [
        "rpi4SSH"
        "rpi4NixSigningKey"
      ];
    };

    # Nix signing keys
    nix.settings.secret-key-files = [ config.age.secrets.rpi4NixSigningKey.path ];

    # Used for building systems remotely
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; 

    # SSH config
    programs.ssh = {
      hosts = {
        rpi4 = {
          order = 11;
          HostName = "192.168.33.122";
          User = "admin";
          IdentityFile = config.age.secrets.rpi4SSH.path;
          IdentitiesOnly = true;
        };
      };
      knownHosts = {
        rpi4 = {
          publicKey = agenixRegistry.machines.rpi4;
          hostNames = [ "192.168.33.122" ];
        };
      };
    };
  };
}
