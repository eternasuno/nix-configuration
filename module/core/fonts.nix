{ pkgs, ... }:
{
  # ====================================================
  # System Level
  # ====================================================
  fonts = {
    packages = with pkgs; [
      maple-mono.NL-TTF-AutoHint
      maple-mono.NL-NF-CN
      noto-fonts-color-emoji
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Maple Mono NL"
          "Maple Mono NL NF CN"
        ];
        serif = [
          "Maple Mono NL"
          "Maple Mono NL NF CN"
        ];
        monospace = [
          "Maple Mono NL"
          "Maple Mono NL NF CN"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
