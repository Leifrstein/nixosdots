{
  pkgs,
  inputs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.leifrstein = {
      imports = [
        ../home-modules
        inputs.nix-index-database.homeModules.nix-index
        inputs.catppuccin.homeModules.catppuccin
        inputs.spicetify-nix.homeManagerModules.spicetify
        inputs.nixcord.homeModules.nixcord
      ];
    };
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
