inputs: {
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      enableMiddleClickPaste = false;
      clickItemTo = "select";
    };
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    input = {
      keyboard = {
        repeatRate = 33;
        repeatDelay = 500;
      };
      mice = [{
        name = "Logitech G305";
        enable = true;
        vendorId = "046d";
        productId = "4074";
        middleButtonEmulation = false;
        accelerationProfile = "none";
        acceleration = -0.42;
      }];
    };
    kwin.effects.shakeCursor.enable = false; # Disable cursor magnification on shake
    kwin.virtualDesktops = {
      rows = 2;
      names = [
        "Desktop 1"
        "Desktop 2"
        "Desktop 3"
        "Desktop 4"
      ];
    };
    panels = [
      {
        location = "bottom";
        floating = true;
        screen = "all";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General.icon = "nix-snowflake";
          }
          "org.kde.plasma.marginsseparator"
          {
            name = "org.kde.plasma.pager";
            config.General = {
              showWindowOutlines = false;
              showOnlyCurrentScreen = true;
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
    kwin.edgeBarrier = 0;
    configFile.kdeglobals.General = {
      TerminalApplication = "alacritty";
      TerminalService = "Alacritty.desktop";
    };
    shortcuts = {
      "services/Alacritty.desktop"."_launch" = "Meta+Return";
    };
    krunner.shortcuts.launch = "Meta+Space";
    krunner.shortcuts.runCommandOnClipboard = "Meta+Alt+Space";
  };
}
