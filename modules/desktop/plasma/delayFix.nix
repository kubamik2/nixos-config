{ config, helpers, ... }:
helpers.mkOptionalModule config {
  path = "desktop.plasma.delayFix";
  description = "Enable KDE Plasma delay fix";
  moduleConfig = {
    systemd.user.services.plasma-delay-fix = {
      enable = true;
      wantedBy = [ "default.target" ];
      script = ''
        mkdir -p ~/.local/share/plasma/desktoptheme/default/translucent &&
        touch ~/.local/share/plasma/desktoptheme/default/translucent/colors
      '';
    };
  };
}
