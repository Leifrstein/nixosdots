{pkgs, ...}: {
  home.packages = with pkgs; [
    gamescope # Used by Lutris for control over game resolution
    lutris
    prismlauncher
    temurin-bin # Temurin JDK 21 binary
    mangohud
    goverlay
    ludusavi
    protontricks
    wine
    winetricks
    obs-studio
    dualsensectl # Dualsense tool - requires compiling
    trigger-control # Dualsense triggers settings - requires compiling
    umu-launcher
    #logmein-hamachi
    #haguichi
  ];

  # Enable wine-ge's fsync support
  home.sessionVariables.WINEFSYNC = 1;
}
