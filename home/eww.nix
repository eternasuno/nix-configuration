{inputs, pkgs, ...}: {
  imports = [inputs.fufexan.homeManagerModules.eww-hyprland];

  programs.eww-hyprland = {
    enable = true;

    package = pkgs.eww-wayland;

    autoReload = false;
  };
}
