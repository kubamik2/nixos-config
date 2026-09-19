{
  helpers,
  pkgs,
  config,
  ...
}:
helpers.mkOptionalModule config {
  path = "common.packages";
  description = "Enable common packages";
  moduleConfig = {
    environment.systemPackages = with pkgs; [
      unzip
      fastfetch
      git
    ];
  };
}
