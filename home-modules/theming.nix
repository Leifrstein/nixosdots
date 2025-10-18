{
  pkgs,
  config,
  osConfig,
  ...
}: {
  # Does not use global enable option for some reason
  catppuccin.gtk.enable = true;

  gtk = {
    enable = true;
    cursorTheme = config.stylix.cursor;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  qt = rec {
    enable = true;
    style.name = "kvantum";
    platformTheme = style;
  };

  home.packages = with pkgs; [
    # fallback icon theme
    adwaita-icon-theme
    # Tools for making catppuccin ports
    catppuccin-catwalk
    catppuccin-whiskers
    just
  ];

  # Inherit system-level settings
  catppuccin = {
    inherit
      (osConfig.catppuccin)
      enable
      cache
      flavor
      accent
      ;
    swaync.enable = false;
  };

  # Required for btop theme
  xdg.enable = true;
}
