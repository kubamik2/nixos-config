{
  lib,
  config,
  ...
}:
let
  moduleName = "<ModuleName>";
  description = "<Description>";
in
{
  options.modules.${moduleName}.enable = lib.mkEnableOption description;

  config = lib.mkIf config.modules.${moduleName}.enable {
    # Config here
  };
}
