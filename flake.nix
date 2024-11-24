{
  description = "A utility to cd up directories faster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
      mkPkgs = system: nixpkgs.legacyPackages.${system};
    in {
      packages = eachSystem (system:
        let pkgs = mkPkgs system;
        in {
          default = pkgs.stdenv.mkDerivation {
            pname = "up-core";
            name = "up";
            version = "1.0.0";
            src = ./.;
            buildInputs = [ pkgs.gcc pkgs.gnumake ];
            buildPhase = "make build";
            installPhase = ''
              mkdir -p $out/bin
              cp up-core $out/bin
            '';
          };
        });
    };
}
