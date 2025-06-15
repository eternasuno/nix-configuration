{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { niriSupport = true; };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "network" "battery" "cpu" "memory" ];

        "niri/workspaces" = {
          all-outputs = true;
          sort-by = "id";
          format = "{name}";
        };

        "clock" = {
          format = "{%b %d %a %H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M:%S}";
          tooltip-format = "<big>{:%Y年%B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-muted = "Muted ";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
          tooltip-format = "{ifname} via {gwaddr} ";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        
        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󱘖";
          format-alt = "{time} {icon}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = "CPU Usage";
        };

        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = "Memory Usage";
        };

      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Noto Sans", sans-serif;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base05};
      }
      
      #workspaces button {
        padding: 0px 5px;
        background: transparent;
        color: #${config.lib.stylix.colors.base04};
      }

      #workspaces button:hover {
        color: #${config.lib.stylix.colors.base08};
      }
      
      #workspaces button.active {
        color: #${config.lib.stylix.colors.base08};
      }

      #clock, #battery, #cpu, #memory, #pulseaudio, #network, #tray {
        padding: 0 10px;
        margin: 0 2px;
        background: #${config.lib.stylix.colors.base04};
        color: #${config.lib.stylix.colors.base00};
      }
      
      #battery.warning {
        color: #f1fa8c; /* 黄色 */
      }
      #battery.critical {
        color: #ff5555; /* 红色 */
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      @keyframes blink {
          to {
              background-color: #ff5555;
              color: #f8f8f2;
          }
      }
    '';
  };

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
  ];
}
