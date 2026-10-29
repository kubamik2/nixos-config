{
  fenix,
  pkgs,
  ...
}:
{
  rust =
    with pkgs;
    mkShell {
      buildInputs = [
        fenix.packages.${system}.stable.toolchain
      ];
    };
}
