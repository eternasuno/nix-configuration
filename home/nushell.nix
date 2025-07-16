{
  pkgs,
  vars,
  ...
}:
let
  inherit (vars) host;
in
{
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    nushell = {
      enable = true;
      environmentVariables = {
        SHELL = "${pkgs.nushell}/bin/nu";
      };
      plugins = with pkgs.nushellPlugins; [
        query
        gstat
      ];
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
      shellAliases = {
        ".." = "cd ..";
        cat = "bat";
        fr = "nh os switch --hostname ${host}";
        fu = "nh os switch --hostname ${host} --update";
        sv = "sudo nvim";
        v = "nvim";
      };
      extraConfig = ''
        def ncg [] {
          nix-collect-garbage --delete-old
          sudo nix-collect-garbage -d
          sudo /run/current-system/bin/switch-to-configuration boot
        }
      '';
    };
  };
}
