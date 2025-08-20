{ vars, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 3d --keep 3";
    };
    flake = "/home/${vars.username}/.config/nixos";
  };

  home.packages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
