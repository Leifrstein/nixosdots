{
  description = "My NixOS dots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    # Use nix-index without having to generate the database locally
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Flake Parts module for defining configs
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix user repository
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    # Generate configs
    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri compositor
    # Provides a binary cache, so do not follow inputs
    niri.url = "github:sodiboo/niri-flake";

    # For theming
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        #home-manager.follows = "home-manager";
      };
    };

    ttf-to-tty = {
      url = "github:Sigmanificient/ttf_to_tty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin Theming
    # Provides a binary cache, so do not follow inputs
    catppuccin.url = "github:catppuccin/nix";

    # Extra Catppuccin themes
    catppuccin-ohmyrepl = {
      url = "github:catppuccin/ohmyrepl";
      flake = false;
    };

    # Catppuccin wallpapers
    catppuccin-wallpapers = {
      url = "github:orangci/walls-catppuccin-mocha";
      flake = false;
    };

    # Gaming tweaks
    # Provides a binary cache, so do not follow inputs
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Spotify customization
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Discord customization
    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Alejandra nix code formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} rec {
      imports = [
        inputs.ez-configs.flakeModule
      ];

      ezConfigs = {
        root = ./.;
        globalArgs = {
          inherit inputs;
          inherit (flake) diskoConfigurations;
        };
      };

      # Expose this to use flake directly with Disko
      flake.diskoConfigurations = import ./disko-configurations;

      systems = ["x86_64-linux"];

      perSystem = args @ {
        pkgs,
        inputs',
        ...
      }: {
        formatter = pkgs.alejandra;
        packages = import ./scripts args;
      };
    };
}
