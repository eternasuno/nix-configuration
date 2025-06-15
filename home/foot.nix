{pkgs, ...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = { shell = "${pkgs.nushell}/bin/nu"; };
      mouse = { hide-when-typing = "yes"; };
      #key-bindings = {
      #  copy-selection = "Super+c";
      #  paste-clipboard = "Super+v";
      #};
    };
  };
}
