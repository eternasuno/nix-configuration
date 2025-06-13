{ pkgs, ... }: {
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    nushell = {
      enable = true;
      environmentVariables = { SHELL = "${pkgs.nushell}/bin/nu"; };
      plugins = with pkgs.nushellPlugins; [ query gstat ];
      settings = {
        ls.clickable_links = true;
        rm.always_trash = true;
        show_banner = false;
        table = {
          mode = "rounded";
          index_mode = "always";
          header_on_separator = false;
        };
      };
      shellAliases = { };
    };
  };
}
