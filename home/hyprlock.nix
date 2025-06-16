_: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        immediate_render = true;
        hide_cursor = true;
      };
      auth = {
        "fingerprint:enabled" = true;
      };
      background = {
        blur_passes = 3;
        blur_size = 8;
      };
      input-field = {
        valign = "bottom";
	position = "0%, 10%";
	outline_thickness = 1;
      };
      label = {
        text = ''
          cmd[update:1000] echo "<span font-weight='light' >$(date +'%H %M %S')</span>"
        '';
        font_size = 300;
        font_family = "Adwaita Sans Thin";
        color = "rgb(8a9e6b)";
        position = "0%, 2%";
        valign = "center";
        halign = "center";
        shadow_color = "rgba(5, 7, 5, 0.1)";
        shadow_size = 20;
        shadow_passes = 2;
        shadow_boost = 0.3;
      };
    };
  };
}
