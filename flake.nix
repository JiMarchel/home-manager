{
  description = "Home Manager configuration of marchel";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim , ... } :
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."marchel" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
		    ./home/default.nix 
        nixvim.homeManagerModules.nixvim
  		  ];
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ 
          rustc 
          cargo 
          cargo-watch
          cargo-expand
          sqlx-cli
          openssl.dev 
          pkg-config 
          ];

          shellHook = ''
              echo "Welcome to the shell!"
          '';
       };
    };
}
