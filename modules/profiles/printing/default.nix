{
  config,
  helpers,
  pkgs,
  ...
}:
{
  imports = helpers.importAll ./.;
}
// helpers.mkOptionalModule config {
  path = "profiles.printing";
  description = "Enable printing modules";
  moduleConfig = {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    hardware.sane.enable = true;
  };
}
