{pkgs, ...}: {
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "leifrstein";
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
    #defaultSession = "niri";
  };
}
