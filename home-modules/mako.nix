{config, ...}: {
  services.mako = {
    enable = true;
    settings = {
      icons = true;
      sort = "-time";
      layer = "overlay";
      anchor = "bottom-right";
      width = 400;
      height = 230;
      padding = "16";
      margin = "10,10,10";
      output = "DP-3";
      border-size = 2;
    };
    extraConfig = ''
      format=<b>%s</b>\n\n%b
    '';
  };
}
