{ pkgs ? import <nixpkgs> {} }:
with pkgs;
mkShell {
    nativeBuildInputs = [ 
    rustc 
    clippy
    cargo 
    cargo-watch
    cargo-expand
    cargo-chef
    sqlx-cli
    openssl.dev 
    pkg-config 
    ];

    shellHook = ''
        echo "Welcome to the shell!"
    '';
}
