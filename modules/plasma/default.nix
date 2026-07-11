{ lib, config, ... }:
let
  cfg = config.modules.plasma;
in
{
  imports = [
    ./delay_fix.nix
    ./essentials.nix
  ];

  options.modules.plasma.enable = lib.mkEnableOption "Enable KDE Plasma desktop environment";

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;

    modules.plasma.delay_fix.enable = true;
    modules.plasma.essentials.enable = true;
  };
}
