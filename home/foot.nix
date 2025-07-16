{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "${pkgs.nushell}/bin/nu";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
