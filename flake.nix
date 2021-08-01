{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    py-mahjong = { url = "github:MahjongRepository/mahjong/v1.1.11"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs   = nixpkgs.legacyPackages.${system};

    hspkg = pkgs.haskellPackages.callCabal2nix "fufu-api" ./. {};

  in {
    defaultPackage.${system} =
      hspkg.overrideAttrs (old: {

        buildInputs = (old.buildInputs or []) ++ (with pkgs; [
          (python3Full.withPackages (pp: with pp; [
            (pp.buildPythonPackage {
              pname   = "mahjong";
              version = "v1.1.11";
              src     = inputs.py-mahjong;
            })
          ]))
        ]);

        nativeBuildInputs = (old.nativeBuildInputs or []) ++ (with pkgs; [
          cabal-install
        ]);
      });
  };
}
