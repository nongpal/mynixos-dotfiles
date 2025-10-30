{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations.finola = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };

      packages.x86_64-linux.default = nixpkgs.mkShell {
        buildInputs = with nixpkgs; [
          raylib
        ];
      };
    };
}
