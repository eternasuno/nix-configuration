{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.kitty = {
    package = pkgs.emptyDirectory;
    settings = {
      macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = "yes";
      shell = "${pkgs.nushell}/bin/nu";
    };
  };

  homebrew.casks = ["kitty"];
}
