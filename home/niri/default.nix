{ inputs, pkgs, ... }: {
  imports =
    [ ./settings.nix ./binds.nix ./rules.nix inputs.niri.homeModules.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
