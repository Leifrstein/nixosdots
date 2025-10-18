{pkgs, ...}: {
  environment.systemPackages = with pkgs; [ddcutil];
  hardware.i2c.enable = true;
  users.extraGroups.i2c.members = ["leifrstein"];
}
