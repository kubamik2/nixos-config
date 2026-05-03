{ pkgs, ... }: {
  stylix.targets.waybar.font = "serif";

  programs.waybar = {
    enable = true;
    settings.main = {
      layer = "top"; # Waybar at top layer
      # position = "bottom"; # Waybar position (top|bottom|left|right)
      # height = 30; # Waybar height (to be removed for auto height)
      # width = 1280; # Waybar width
      spacing = 4; # Gaps between modules (4px)
      # Choose the order of the modules
      modules-left = [
        "hyprland/workspaces"
        # "custom/media"
      ];
      modules-center = [
        # "hyprland/window"
      ];
      modules-right = [
        "tray"
        "mpd"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "power-profiles-daemon"
        "battery"
        "clock"
        "custom/power"
      ];
      # Modules configuration
      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        warp-on-scroll = false;
        format = "{icon}";
        format-icons = {
          urgent = "";
          focused = "";
          active = "";
          default = "";
        };
        persistent-workspaces = {
          "*" = 5;
        };
      };
      keyboard-state = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      "sway/scratchpad" = {
        format = "{icon} {count}";
        show-empty = false;
        format-icons = ["" ""];
        tooltip = true;
        tooltip-format = "{app}: {title}";
      };
      mpd = {
        format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
        format-disconnected = "Disconnected ";
        format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        unknown-tag = "N/A";
        interval = 5;
        consume-icons = {
          on = " ";
        };
        random-icons = {
          off = "<span color=\"#f53c3c\"></span> ";
          on = " ";
        };
        repeat-icons = {
          on = " ";
        };
        single-icons = {
          on = "1 ";
        };
        state-icons = {
          paused = "";
          playing = "";
        };
        tooltip-format = "MPD (connected)";
        tooltip-format-disconnected = "MPD (disconnected)";
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      tray = {
        icon-size = 21;
        spacing = 10;
        # icons = {
        #   blueman = "bluetooth";
        #   TelegramDesktop = "$HOME/.local/share/icons/hicolor/16x16/apps/telegram.png";
        # };
      };
      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      cpu = {
        "format" = "{usage}% ";
        "tooltip" = false;
      };
      memory = {
        format = "{}% ";
      };
      temperature = {
        # thermal-zone = 2;
        # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        critical-threshold = 80;
        # format-critical = "{temperatureC}°C {icon}";
        format = "{temperatureC}°C {icon}";
        format-icons = [""];
      };
      backlight = {
        # device = "acpi_video1";
        format = "{percent}% {icon}";
        format-icons = ["" "" "" "" "" "" "" "" ""];
      };
      battery = {
        states = {
          # good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% 󰂄";
        format-plugged = "{capacity}% 󰂄";
        format-alt = "{time} {icon}";
        # format-good = ""; # An empty format will hide the module
        # format-full = "";
        format-icons = ["󰂎" "󰁻" "󰁾" "󰂀" "󰁹"];
        # format-icons = ["" "" "" "" ""];
      };
      "battery#bat2" = {
        bat = "BAT2";
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };
      network = {
        # interface = "wlp2*"; # (Optional) To force the use of this interface
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} 󰊗";
        tooltip-format = "{ipaddr}";
        format-linked = "{ifname} (No IP) 󰊗";
        format-disconnected = "Disconnected ⚠";
        on-click = "nm-connection-editor";
      };
      pulseaudio = {
        # scroll-step = 1; # %, can be a float
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "󰅶 {icon} {format_source}";
        format-muted = "󰅶 {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "󰂑";
          headset = "󰂑";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      # "custom/media" = {
      #   format = "{icon} {text}";
      #   return-type = "json";
      #   max-length = 40;
      #   format-icons = {
      #     spotify = "";
      #     default = "🎜";
      #   };
      #   escape = true;
      #   exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
      #   # exec = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null"; # Filter player based on name
      # };
      "custom/power" = {
        format  = "⏻";
        tooltip = false;
        menu = "on-click";
        menu-file = "$HOME/.config/waybar/power_menu.xml"; # Menu file in resources folder
        menu-actions = {
          shutdown = "hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'";
          reboot = "hyprshutdown -t 'Restarting...' --post-cmd 'reboot'";
          suspend = "systemctl suspend";
          hibernate = "systemctl hibernate";
        };
      };
    };
    style = ''
      #mpd, #idle_inhibitor, #pulseaudio, #network, #power-profiles-daemon, #cpu, #memory, #temperature, #backlight, #battery, #clock, #tray, #custom-power, #workspaces {
        padding: 0 8px;
        margin: 4px 2px;
        border-radius: 20px;
        background-color: @base01;
      }

      #custom-power {
        color: @base09;
        margin-right: 4px;
      }

      #workspaces {
        margin-left: 4px; 
      }

      window#waybar {
        background: transparent;
      }

      #workspaces button {
          padding: 0 5px;
      }
    '';
      #idle_inhibitor, #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
#     style = ''
# * {
#     border: none;
#     border-radius: 0;
#     font-family: "Ubuntu Nerd Font";
#     font-size: 13px;
#     min-height: 0;
# }
#
# window#waybar {
#     background: transparent;
#     color: white;
# }
#
# #window {
#     font-weight: bold;
#     font-family: "Ubuntu";
# }
# /*
# #workspaces {
#     padding: 0 5px;
# }
# */
#
# #workspaces button {
#     padding: 0 5px;
#     background: transparent;
#     color: white;
#     border-top: 2px solid transparent;
# }
#
# #workspaces button.focused {
#     color: #c9545d;
#     border-top: 2px solid #c9545d;
# }
#
# #mode {
#     background: #64727D;
#     border-bottom: 3px solid white;
# }
#
# #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
#     padding: 0 3px;
#     margin: 0 2px;
# }
#
# #clock {
#     font-weight: bold;
# }
#
# #battery {
# }
#
# #battery icon {
#     color: red;
# }
#
# #battery.charging {
# }
#
# @keyframes blink {
#     to {
#         background-color: #ffffff;
#         color: black;
#     }
# }
#
# #battery.warning:not(.charging) {
#     color: white;
#     animation-name: blink;
#     animation-duration: 0.5s;
#     animation-timing-function: linear;
#     animation-iteration-count: infinite;
#     animation-direction: alternate;
# }
#
# #cpu {
# }
#
# #memory {
# }
#
# #network {
# }
#
# #network.disconnected {
#     background: #f53c3c;
# }
#
# #pulseaudio {
# }
#
# #pulseaudio.muted {
# }
#
# #custom-spotify {
#     color: rgb(102, 220, 105);
# }
#
# #tray {
# }
#     '';
  };
  home.file.".config/waybar/power_menu.xml".source = ./power_menu.xml;
  home.packages = with pkgs; [ font-awesome ];
}
