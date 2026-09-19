{
  helpers,
  pkgs,
  config,
  ...
}:
helpers.mkOptionalModule config {
  path = "programs.piper";
  description = "Enable piper";
  moduleConfig = {
    environment.systemPackages = [ pkgs.piper ];
    services.ratbagd.enable = true;
  };
}
