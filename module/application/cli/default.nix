{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  imports = [
    ./bat.nix
    ./fzf.nix
    ./zoxide.nix
    # ./eza.nix
    ./lazygit.nix
    ./yazi
  ];

  home-manager.users.${username}.home.packages = with pkgs; [
    delta
    ffmpegthumbnailer
    unar
    jq
    poppler-utils
    fd
    ripgrep
    imagemagick
  ];
}
