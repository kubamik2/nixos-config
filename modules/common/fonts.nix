{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.common.fonts;
in
{
  options.modules.common.fonts = {
    enable = lib.mkEnableOption "Enable common fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      ipafont
    ];
  };
}
