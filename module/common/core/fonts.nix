{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    maple-mono.NL-TTF-AutoHint
    maple-mono.NL-NF-CN
    noto-fonts-color-emoji
  ];
}
