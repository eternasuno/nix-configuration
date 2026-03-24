{
  description = "Nixos configuration.";

  outputs =
    { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs.lib) filterAttrs;
      inherit (builtins) mapAttrs pathExists readDir;
      hosts = filterAttrs (_: type: type == "directory") (readDir ./hosts);
      toConfiguration = host: _: import ./hosts/${host} host inputs;
      isNixosHost = host: pathExists ./hosts/${host}/hardware-configuration.nix;
      nixosHosts = filterAttrs (host: _: isNixosHost host) hosts;
      darwinHosts = filterAttrs (host: _: !(isNixosHost host)) hosts;
      nixosConfigurations = mapAttrs toConfiguration nixosHosts;
      darwinConfigurations = mapAttrs toConfiguration darwinHosts;
    in
    {
      inherit nixosConfigurations;
      inherit darwinConfigurations;
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell/v1.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
  };
}
