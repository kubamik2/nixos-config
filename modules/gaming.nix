{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming.enable = lib.mkEnableOption "Enable various gaming programs";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
      lutris
    ];
  };
}
