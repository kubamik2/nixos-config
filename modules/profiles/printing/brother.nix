{
  config,
  helpers,
  pkgs,
  ...
}:
helpers.mkOptionalModule config {
  path = "profiles.printing.brother";
  description = "Enable brother printer drivers";
  moduleConfig = {
    services.printing.drivers = with pkgs; [
      brgenml1lpr
    ];
    hardware.sane.brscan5.enable = true;
  };
}
