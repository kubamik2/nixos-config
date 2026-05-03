inputs: {
  imports = [
    ./alacritty.nix
    ./hypridle.nix
    ./waybar
    ./hyprlock.nix
    ./theme.nix
    ./wofi.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = "waybar & swaync & hypridle & systemctl --user start hyprpolkitagent";
      monitor = ",2880x1800@90,auto,2";

      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "wofi --show drun";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;

        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };

        # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # https://wiki.hypr.land/Configuring/Variables/#animations
      animations = {
        enabled = "yes, please :)";

        # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
        #        NAME,           X0,   Y0,   X1,   Y1
        bezier = [
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];

        # Default animations, see https://wiki.hypr.land/Configuring/Animations/
        #           NAME,          ONOFF, SPEED, CURVE,        [STYLE]
        animation = [
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  almostLinear, fade"
          "workspacesIn,  1,     1.21,  almostLinear, fade"
          "workspacesOut, 1,     1.94,  almostLinear, fade"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      # workspace = w[tv1], gapsout:0, gapsin:0
      # workspace = f[1], gapsout:0, gapsin:0
      # windowrule {
      #     name = no-gaps-wtv1
      #     match:float = false
      #     match:workspace = w[tv1]
      #
      #     border_size = 0
      #     rounding = 0
      # }
      #
      # windowrule {
      #     name = no-gaps-f1
      #     match:float = false
      #     match:workspace = f[1]
      #
      #     border_size = 0
      #     rounding = 0
      # }

      # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hypr.land/Configuring/Variables/#misc
      misc = {
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
      };

      #############
      ### INPUT ###
      #############

      # https://wiki.hypr.land/Configuring/Variables/#input
      input = {
        kb_layout = "us";
        # kb_variant =
        # kb_model =
        # kb_options =
        # kb_rules =
        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
        };
        repeat_rate = 33;
        repeat_delay = 500;
      };

      # See https://wiki.hypr.land/Configuring/Gestures
      gesture = "3, horizontal, workspace";

      # Example per-device config
      # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      ###################
      ### KEYBINDINGS ###
      ###################

      # See https://wiki.hypr.land/Configuring/Keywords/
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

      # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
      bind = [
        "$mainMod, return, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, T, togglefloating,"
        "$mainMod, space, exec, $menu"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, N, layoutmsg, togglesplit" # dwindle

        # Screenshotting
        ", PRINT, exec, hyprshot -m window"
        "shift, PRINT, exec, hyprshot -m region"

        # Locking
        "$SUPER_SHIFT, l, exec, hyprlock"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus with mainMod + vim direction keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        # Requires playerctl
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
      # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrules that are useful

      windowrule = [
        {
          # Ignore maximize requests from all apps. You'll probably like this.
          name = "suppress-maximize-events";
          "match:class" = ".*";
          suppress_event = "maximize";
        }

        {
          # Fix some dragging issues with XWayland
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;

          no_focus = true;
        }

        {
          # Hyprland-run windowrule
          name = "move-hyprland-run";

          "match:class" = "hyprland-run";

          move = "20 monitor_h-120";
          float = "yes";
        }
      ];
    };
  };
}
