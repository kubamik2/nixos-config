{
  lib,
  helpers,
  config,
  ...
}:
{
  imports = helpers.importAll ./.;
}
// helpers.mkOptionalModule config {
  path = "common";
  description = "Enable common modules";
  moduleConfig = {
    modules.common.fonts.enable = true;
    modules.common.packages.enable = true;
  };
}
