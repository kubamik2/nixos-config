{
  pkgs,
  lib,
  config,
  ...
}:
let
  moduleName = "piper";
  description = "Enable piper";
in
{
  options.modules.${moduleName}.enable = lib.mkEnableOption description;

  config = lib.mkIf config.modules.${moduleName}.enable {
    environment.systemPackages = [ pkgs.piper ];
    services.ratbagd.enable = true;
  };
}
