{ pkgs, ... }:
{
  imports = [ ./fonts-packages.nix ];

  fonts.fontconfig = {
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
