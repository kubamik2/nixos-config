{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.common.packages;
in
{
  options.modules.common.packages = {
    enable = lib.mkEnableOption "Enable common packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      unzip
      fastfetch
      git
    ];
  };
}
