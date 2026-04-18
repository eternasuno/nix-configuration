{
  vars,
  inputs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 3d --keep 3";
      };
      flake = inputs.self;
    };
  };
}
