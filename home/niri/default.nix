{ config, inputs, pkgs, ... }: {
  imports =
    [ ./settings.nix ./binds.nix ./rules.nix inputs.niri.homeModules.niri ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  home.packages = with pkgs; [ cliphist jaq playerctl seatd swww wl-clipboard ];
}
