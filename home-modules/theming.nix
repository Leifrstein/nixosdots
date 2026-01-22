{
  pkgs,
  config,
  osConfig,
  ...
}: {

  gtk = {
    enable = true;
    cursorTheme = config.stylix.cursor;
    theme = {
			name = "Catppuccin-GTK-Mauve-Dark";
      package = pkgs.magnetic-catppuccin-gtk.override {
				tweaks = ["black"];
				accent = ["mauve"];
				shade = "dark";
			};
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
    rose-pine-gtk-theme
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
    mako.enable = true;
    gitui.enable = true;
  };

  # Required for btop theme
  xdg.enable = true;
}
