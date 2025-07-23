{ config, pkgs, ... }:
{
  programs.niri.settings.binds =
    with config.lib.niri.actions;
    let
      set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
      brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
      playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
    in
    {
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

      "XF86AudioPlay".action = playerctl "play-pause";
      "XF86AudioStop".action = playerctl "pause";
      "XF86AudioPrev".action = playerctl "previous";
      "XF86AudioNext".action = playerctl "next";

      "XF86AudioRaiseVolume".action = set-volume "5%+";
      "XF86AudioLowerVolume".action = set-volume "5%-";

      "XF86MonBrightnessUp".action = brillo "-A" "5";
      "XF86MonBrightnessDown".action = brillo "-U" "5";

      "Mod+Alt+Print".action.screenshot-screen = {
        write-to-disk = true;
      };
      "Mod+Print".action.screenshot-window = {
        write-to-disk = true;
      };
      "Print".action.screenshot = {
        show-pointer = false;
      };

      "Mod+Q".action = close-window;

      "Mod+Ctrl+S".action = switch-preset-column-width;

      # "Mod+F".action = maximize-column;
      # "Mod+Shift+F".action = expand-column-to-available-width;
      # "Mod+F".action = toggle-window-floating;
      # "Mod+W".action = toggle-column-tabbed-display;

      # "Mod+Comma".action = consume-window-into-column;
      # "Mod+Period".action = expel-window-from-column;
      # "Mod+C".action = center-visible-columns;
      "Mod+F".action = switch-focus-between-floating-and-tiling;

      # "Mod+Minus".action = set-column-width "-10%";
      # "Mod+Plus".action = set-column-width "+10%";
      # "Mod+Shift+Minus".action = set-window-height "-10%";
      # "Mod+Shift+Plus".action = set-window-height "+10%";

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Down".action = focus-workspace-down;
      "Mod+Up".action = focus-workspace-up;

      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+K".action = move-column-to-workspace-up;
      "Mod+Shift+J".action = move-column-to-workspace-down;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-column-to-workspace-up;
      "Mod+Shift+Down".action = move-column-to-workspace-down;

      "Mod+Shift+Alt+J".action = move-column-to-monitor-down;
      "Mod+Shift+Alt+K".action = move-column-to-monitor-up;

      "Mod+T".action = spawn "foot";
      "Mod+B".action = spawn "firefox";
    };
}
