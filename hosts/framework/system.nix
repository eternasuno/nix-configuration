{
  inputs,
  pkgs,
  vars,
  ...
}:
let
  inherit (vars) version;
in
{
  imports = [
    ../../system/boot.nix
    ../../system/greetd.nix
    ../../system/hardware.nix
    ../../system/locale.nix
    ../../system/network.nix
    ../../system/nix.nix
    ../../system/packages.nix
    ../../system/security.nix
    ../../system/services.nix
    ../../system/user.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  system.stateVersion = version;
}
