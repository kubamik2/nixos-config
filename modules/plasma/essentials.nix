{
  config,
  pkgs,
  helpers,
  ...
}:
helpers.mkOptionalModule config {
  path = "plasma.essentials";
  description = "Enable essential programs for KDE Plasma";
  moduleConfig = {
    environment.systemPackages = with pkgs; [
      kdePackages.filelight
      kdePackages.kalk
    ];

    programs.partition-manager.enable = true;
  };
}
