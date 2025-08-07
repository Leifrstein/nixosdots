{
  services.gammastep = {
    enable = true;
    enableVerboseLogging = true;
    #provider = "geoclue2"; # not working
    provider = "manual";
    latitude = -18.9;
    longitude = -48.3;
    temperature = {
      day = 5000;
      night = 1900;
    };
    tray = true;
    settings = {
      general.adjustment-method = "wayland";
    };
  };
}
