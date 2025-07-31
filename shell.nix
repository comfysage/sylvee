{
  pkgs ? import <nixpkgs> {},
}: pkgs.mkShellNoCC {
  packages = [
    pkgs.stylua
    pkgs.lua-language-server
  ];
}
