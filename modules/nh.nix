{ lib, config, ... }:
let
  cfg = config.modules.nh;
in
{
  options.modules.nh = {
    enable = lib.mkEnableOption "Enable nh";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "/home/kubamik2/.config/nixos-config";
    };
  };
}
