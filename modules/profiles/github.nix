{
  config,
  helpers,
  ...
}:
helpers.mkOptionalModule config {
  path = "profiles.github";
  description = "Github profile";
  moduleConfig = {
    # Agenix config
    modules.programs.agenix = {
      enable = true;
      enabledKeys = [ "github" ];
    };

    # SSH config
    programs.ssh = {
      startAgent = true;
      hosts = {
        "github.com" = {
          order = 10;
          HostName = "github.com";
          User = "kubamik2";
          AddKeysToAgent = "60m";
          IdentityFile = config.age.secrets.github.path;
          IdentitiesOnly = true;
        };
      };
    };
  };
}
