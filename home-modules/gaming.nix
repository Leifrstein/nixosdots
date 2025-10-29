{pkgs, ...}: {
  home.packages = with pkgs; [
    gamescope # Used by Lutris for control over game resolution
    lutris
    prismlauncher
    zeroad
    temurin-bin # Temurin JDK 21 binary
    mangohud
    goverlay
    ludusavi
    protontricks
    protonup-ng
    wine
    winetricks
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    dualsensectl # Dualsense tool - requires compiling
    trigger-control # Dualsense triggers settings - requires compiling
    bottles
    umu-launcher
    #logmein-hamachi
    #haguichi
  ];

  # Enable wine-ge's fsync support
  home.sessionVariables.WINEFSYNC = 1;
}
