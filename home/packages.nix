{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cliphist
    jaq
    networkmanagerapplet
    pavucontrol
    playerctl
    quickshell
    seatd
    swww
    wl-clipboard
  ];
}
