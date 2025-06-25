{
  inputs,
  pkgs,
  vars,
  ...
}:
let
  inherit (vars) username model version;
  inherit (inputs) home-manager nixos-hardware;
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
    home-manager.nixosModules.home-manager
    nixos-hardware.nixosModules.${model}
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${username} = {
      imports = [
        ../../home/foot.nix
        ../../home/hyprlock.nix
        ../../home/librewolf.nix
        ../../home/niri
        ../../home/nushell.nix
        ../../home/packages.nix
        ../../home/sessionVariables.nix
        ../../home/stylix.nix
        ../../home/swayidle.nix
        ../../home/waybar.nix
        ../../home/xdg.nix
      ];
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = version;
      };
    };
  };

  system.stateVersion = version;
}
