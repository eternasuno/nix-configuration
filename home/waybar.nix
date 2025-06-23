{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { niriSupport = true; };
    settings = {
      mainBar = {
        layer= "top",
        position= "top",
        height= 0,
        spacing= 0,
        margin-top= 12,
        margin-bottom= 5,
        margin-left= 200,
        margin-right= 200,
          modules-left= ["niri/workspaces"],
          modules-center= ["clock"],
          modules-right= [ "tray","backlight", "pulseaudio", "battery"],
          sway/scratchpad= {
            format= "󱂬 {count}"
          },
          pulseaudio= {
            format= "{volume}%"
          },
          backlight= {
          format= "{percent}%",
          format-icons= ["", "", "", "", "", "", "", "", ""],
        },
          "niri/workspaces"= {
            format= "{index}"
          },
          "mpris"= {
            format= "{status_icon} {artist} - {title}",
            format-stopped= "",
            status-icons= {
              paused= "⏸",
              playing= "󰐊"
            },
            interval= "0.1"
          },
          clock= {
            format= "{:%I:%M %p}",
              interval= 1,
              tooltip-format= "{:%A %d %B %Y}"
          },
          "tray": {
            spacing= 12
          },
          "gamemode"= {
              glyph= "   ",
              format= "{glyph}",
              use-icon= false,
              icon-spacing= 16
          },
          memory= {
              format= "  {percentage}%",
              interval= 1
          },
          cpu= {
              format= "  {usage}%",
              interval= 1
          },
          battery= {
            format= "{capacity}%",
            format-charging= "{capacity}% ",
            format-icons= ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
            interval= 1
          }
      };
    };

    style = ''
      * {
        font-size: 15px;
      }

      window#waybar {
        border-bottom: 1px solid #181825;
        border-radius: 10px;
      }

      #clock,
      #tray,
      #battery,
      #cpu,
      #window,
      #memory,
      #network,
      #scratchpad,
      #temperature,
      #pulseaudio,
      #backlight {
        background: transparent;
        padding: 0px 0px;
        border-radius: 6px;
        margin: 0px;
        margin-top: 0px;
        margin-bottom: 0px;
        margin-right: 14px;
      }

      #workspaces {
        margin-left: 5px;
      }

      #workspaces button {
        padding: 0 5px;
        margin-right: 1px;
        border-radius: 4px;
      }

      #workspaces button:hover {
        background-color: rgba(50, 50, 50, 0.5);
        color: #ffffff;
      }

      #workspaces button.active {
        background: #5e81ac;
      }

      #workspaces button.urgent {
        background-color: #fb4934;
        animation: urgentBlink 1s linear infinite alternate;
      }

      #clock{
        font-size: 16px;
      }

      #tray {
        padding: 0px 4px;
      }

      #backlight {
        color: #8fbcbb;
      }
      #pulseaudio {
        color: #88c0d0;
      }

      #battery {
        color: #81a1c1;
      }

      .modules-left,
      .modules-right,
      .modules-center {
        padding: 4px 0px;
      }
    '';
  };
}
