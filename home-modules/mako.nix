{...}: {
  services.mako = {
    enable = true;
    settings = {
      icons = true;
      sort = "-time";
      layer = "overlay";
      anchor = "top-right";
      width = 400;
      padding = "10";
      output = "DP-3";
      border-size = 2;
      default-timeout = 5000;
      format = "<b>%s</b>\\n%b";
    };
  };
}
