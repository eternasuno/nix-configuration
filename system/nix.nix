{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 3d --keep 3";
    };
    flake = "/home/${username}/.config/nixos";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
