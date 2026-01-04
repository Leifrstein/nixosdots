final: prev: {
  lutris = prev.lutris.override {
    extraLibraries = pkgs: with pkgs; [
      libadwaita
      gtk4
    ];
  };
}
