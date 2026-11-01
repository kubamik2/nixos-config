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
    modules.core = {
      fonts.enable = true;
      packages.enable = true;
      nix.enable = true;
      i18n.enable = true;
      keymap.enable = true;
    };
  };
}
