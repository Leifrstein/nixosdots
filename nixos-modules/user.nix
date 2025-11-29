{pkgs, ...}: let
  user = "leifrstein";
  persistDir = "/persist";
  passwordDir = "/${persistDir}/passwords";
in {
  users.users = {
    ${user} = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user
        "networkmanager" # Change network settings
        "gamemode" # Manage gamemode
        "pipewire" # Attempt to improve audio latency by giving it priority
      ];
      hashedPasswordFile = "${passwordDir}/${user}";
    };
    root.hashedPasswordFile = "${passwordDir}/root";
  };

  # /persist is needed for boot because it contains password hashes
  fileSystems.${persistDir}.neededForBoot = true;

  # Need to enable fish at system level to use as shell
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # TTY keyboard layout
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
        variant = "";
        #options = "caps:escape";
      };
    };
  };
}
