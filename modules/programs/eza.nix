{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkOptionalModule config {
  path = "programs.eza";
  description = "Enable eza";
  moduleConfig = {
    environment.systemPackages = [ pkgs.eza ];
    environment.shellAliases.ls = "eza";
  };
}
