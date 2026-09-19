{ config, helpers, ... }:
helpers.mkOptionalModule config {
  path = "systems.plasma.delay_fix";
  description = "Enable KDE Plasma delay fix";
  moduleConfig = {
    systemd.user.services.plasma_delay_fix = {
      enable = true;
      wantedBy = [ "default.target" ];
      script = ''
        mkdir -p ~/.local/share/plasma/desktoptheme/default/translucent &&
        touch ~/.local/share/plasma/desktoptheme/default/translucent/colors
      '';
    };
  };
}
