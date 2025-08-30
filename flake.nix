{
  description = "Luke's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Name each attribute in nixosConfigurations to match machine hostnames.
    # This configuration can be explicitly referenced when upgrading with:
    #
    #   $ nixos-rebuild switch --flake .#hostname
    #
    # If the machine hostname where the above command is run matches a name in
    # nixosConfigurations, it will be selected and `#hostname` can be ommitted.
    # So, on the t480s machine, the above can be:
    #
    #   $ nixos-rebuild switch --flake .
    nixosConfigurations = {
      t480s = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/t480s/configuration.nix
        ];
      };
    };
  };
}
