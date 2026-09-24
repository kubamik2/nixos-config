{
  helpers,
  pkgs,
  config,
  ...
}:
helpers.mkOptionalModule config {
  path = "core.packages";
  description = "Enable common packages";
  moduleConfig = {
    environment.systemPackages = with pkgs; [
      unzip
      fastfetch
      git
    ];
  };
}
