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
  path = "systems.common";
  description = "Enable common modules";
  moduleConfig = {
    modules.systems.common.fonts.enable = true;
    modules.systems.common.packages.enable = true;
  };
}
