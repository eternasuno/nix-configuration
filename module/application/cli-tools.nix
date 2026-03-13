{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs = {
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };
      fzf = {
        enable = true;
        enableNushellIntegration = true;
      };
      bat.enable = true;
      eza = {
        enable = true;
        enableNushellIntegration = true;
      };
    };

    home.packages = with pkgs; [
      lazygit
      delta
      yazi
      ffmpegthumbnailer
      unar
      jq
      poppler_utils
      fd
      ripgrep
      imagemagick
    ];
  };
}
