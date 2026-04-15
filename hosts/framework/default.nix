{
  nixpkgs,
  home-manager,
  lanzaboote,
  nixos-hardware,
  nixpkgs-unfree,
  ...
}@inputs:
let
  vars = {
    host = "framework";
    username = "eternasuno";
    flakePath = "/home/eternasuno/.nixos";
    email = "22316214+eternasuno@users.noreply.github.com";
    keyboardLayout = "us";
    timeZone = "Asia/Tokyo";
    version = "25.05";
  };
in
{
  nixosConfigurations.${vars.host} = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs vars; };
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      nixpkgs-unfree.nixosModules.unfree
      home-manager.nixosModules.home-manager
      lanzaboote.nixosModules.lanzaboote
      nixos-hardware.nixosModules.framework-13-7040-amd
    ];
  };
}
