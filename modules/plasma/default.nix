{
  helpers,
  lib,
  config,
  ...
}:
{
  imports = helpers.importAll ./.;
}
// helpers.mkOptionalModule config {
  path = "plasma";
  description = "Enable KDE Plasma desktop environment";
  moduleConfig = {

    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    modules.plasma.delay_fix.enable = true;
    modules.plasma.essentials.enable = true;
  };
}
