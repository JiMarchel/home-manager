{
  description = "Home Manager configuration of marchel";

  inputs = {
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
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, nixvim , nixGL, ... } @ inputs :
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    in {
      homeConfigurations."marchel" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit self nixpkgs inputs;
        inherit nixGL;
        };
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
