{
  helpers,
  config,
  pkgs,
  ...
}:
helpers.mkOptionalModule config {
  path = "systems.common.fonts";
  description = "Enable common fonts";
  moduleConfig = {
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
