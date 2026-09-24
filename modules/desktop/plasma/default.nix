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
  path = "desktop.plasma";
  description = "Enable KDE Plasma desktop environment";
  moduleConfig = {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    modules.desktop.plasma.delayFix.enable = true;
    modules.desktop.plasma.essentials.enable = true;
  };
}
