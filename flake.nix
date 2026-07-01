{
  description = "Home Manager configuration of skagan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-python310.url = "github:nixos/nixpkgs/15a6983bd3650b968eb59693dfaecb7e82e31c7a";  # Found via Git history on GH
    nixpkgs-python311.url = "github:nixos/nixpkgs/16aa50099ecd6491b90a79703663f2bfa26b453a";
    nixpkgs-mysql57.url = "github:nixos/nixpkgs/06c9198cbf48559191bf6c9b76c0f370f96b8c33";  # Found via https://lazamar.co.uk/nix-versions
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-python310, nixpkgs-python311, nixpkgs-mysql57, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config = {allowUnfree=true;};
      };
      pkgs-mysql57 = import nixpkgs-mysql57 {
        inherit system;
      };
      pkgs-python310 = import nixpkgs-python310 {
        inherit system;
      };
      pkgs-python311 = import nixpkgs-python311 {
        inherit system;
      };
    in {
      homeConfigurations."skagan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit pkgs-mysql57;
          inherit pkgs-python310;
          inherit pkgs-python311;
        };
      };
    };
}
