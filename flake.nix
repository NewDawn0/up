{
  description = "A utility to cd up directories faster";

  inputs.utils.url = "github:NewDawn0/nixUtils";

  outputs = { self, utils, ... }: {
    overlays.default = final: prev: {
      up = self.packages.${prev.system}.default;
    };
    packages = utils.lib.eachSystem { } (pkgs: {
      default = pkgs.stdenv.mkDerivation {
        pname = "up-core";
        version = "1.0.0";
        src = ./.;
        installPhase = ''
          install -D up-core -t $out/bin
          mkdir -p $out/share
          echo "#!/${pkgs.runtimeShell}" > $out/share/SOURCE_ME.sh
          $out/bin/up-core --init >> $out/share/SOURCE_ME.sh
        '';
        shellHook = ''
          source $out/share/SOURCE_ME.sh
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
