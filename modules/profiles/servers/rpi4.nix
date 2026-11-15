{
  config,
  helpers,
  agenixRegistry,
  ...
}:
helpers.mkOptionalModule config {
  path = "profiles.servers.rpi4";
  description = "";
  moduleConfig = {
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
