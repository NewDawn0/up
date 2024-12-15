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
          default = pkgs.gccStdenv.mkDerivation {
            pname = "up-core";
            version = "1.0.0";
            src = pkgs.fetchFromGitHub {
              owner = "NewDawn0";
              repo = "up";
              rev = "1be487a84782bc62593326c35160fa782e2e7d7a";
              hash = "sha256-Ll6gHuWh2s7ke9Vqlw0H3tdKHIuvIC13TGHHKllEQ54=";
            };
            installPhase = ''
              install -D up-core -t $out/bin
              mkdir -p $out/lib
              echo "#!/${pkgs.runtimeShell}" > $out/lib/SOURCE_ME.sh
              $out/bin/up-core --init >> $out/lib/SOURCE_ME.sh
            '';
            shellHook = ''
              source $out/lib/SOURCE_ME.sh
            '';
            meta = {
              description = "A tool to navigate up directories more swiftly";
              longDescription = ''
                This utility allows you to move up relative directories with ease, enhancing efficiency when working in nested file systems. It simplifies navigation with fewer keystrokes.
              '';
              homepage = "https://github.com/NewDawn0/up";
              license = pkgs.lib.licenses.mit;
              maintainers = with pkgs.lib.maintainers; [ NewDawn0 ];
              platmors = pkgs.lib.platforms.all;
            };
          };
        });
    };
}
