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
  path = "systems.plasma";
  description = "Enable KDE Plasma desktop environment";
  moduleConfig = {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    modules.systems.plasma.delay_fix.enable = true;
    modules.systems.plasma.essentials.enable = true;
  };
}
