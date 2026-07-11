{ lib, config, ... }:
let
  cfg = config.modules.nh;
in
{
  imports = [
    ./fonts.nix
    ./packages.nix
  ];

  options.modules.common = {
    enable = lib.mkEnableOption "Enable common modules";
  };

  config = lib.mkIf cfg.enable {
    modules.common.fonts.enable = true;
    modules.common.packages.enable = true;
  };
}
