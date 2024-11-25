let
  nixpkgs =
    import <nixpkgs> { };
in
nixpkgs.mkShell {
  buildInputs = [
    nixpkgs.elixir
  ];
}
