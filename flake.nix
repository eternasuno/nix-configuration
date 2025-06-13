{
  description = "My nixos configuration.";

  outputs = { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs.lib) filterAttrs;
      inherit (builtins) mapAttrs readDir;
      hosts = filterAttrs (_: type: type == "directory") (readDir ./hosts);
      toConfiguration = host: _: import ./hosts/${host} host inputs;
      nixosConfigurations = mapAttrs toConfiguration hosts;
    in { inherit nixosConfigurations; };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nvf.url = "github:notashelf/nvf";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
