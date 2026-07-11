{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.plasma.essentials;
in
{
  options.modules.plasma.essentials.enable =
    lib.mkEnableOption "Enable essential programs for KDE Plasma";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.filelight
      kdePackages.kalk
    ];

    programs.partition-manager.enable = true;
  };
}
