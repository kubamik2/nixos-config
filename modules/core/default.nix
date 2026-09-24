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
  path = "core";
  description = "Enable core modules";
  moduleConfig = {
    modules.core.fonts.enable = true;
    modules.core.packages.enable = true;
  };
}
