{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Import all nix files in directory
  # Should ignore this file and all non-nix files
  imports =
    map (file: ./. + "/${file}") (
      lib.strings.filter (file: lib.strings.hasSuffix ".nix" file && file != "default.nix") (
        builtins.attrNames (builtins.readDir ./.)
      )
    )
    ++ [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence
      inputs.niri.nixosModules.niri
      inputs.stylix.nixosModules.stylix
      inputs.catppuccin.nixosModules.catppuccin
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.spicetify-nix.nixosModules.spicetify
    ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = ["leifrstein"]; # Fixes issue with not being able to use trusted-public-keys sometimes
      cores = 8; # Amount of CPU cores to use for building
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    # Set system registry to flake inputs
    registry = lib.pipe inputs [
      # Remove non flake inputs, which cause errors
      # Flakes have an attribute _type, which equals "flake"
      # while non-flakes lack this attribute
      (lib.filterAttrs (_: flake: lib.attrsets.hasAttr "_type" flake))
      (lib.mapAttrs (_: flake: {inherit flake;}))
    ];
    # For some reason, lix needs this to replace the nix command
    package = pkgs.lix;
  };

  nixpkgs = {
    overlays = [
      # custom overlay
      #(import ../pkgs)
      # Nix user repository
      inputs.nur.overlays.default
    ];
    config.allowUnfree = true;
  };

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    loader = {
      grub = {
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # Enable KVM nested virtualization
    extraModprobeConfig = "options kvm_amd nested=1";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    dnsutils
    git
    nh
    nix-output-monitor
    nvd
    nix-fast-build
    appimage-run
    alejandra
    gnumake
    kdePackages.sddm
    #  wpa_supplicant
  ];

  networking.networkmanager.enable = true;

  location.provider = "geoclue2";
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_CTYPE = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
    LC_COLLATE = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_MESSAGES = "en_GB.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
  };
  # use xkbOptions in tty.
  #console.useXkbConfig = true;
  #console.keyMap = "br";

  hardware = {
    # Enable AMD microcode updates
    enableRedistributableFirmware = true;
  };

  # Enable ssh agent
  #programs.ssh.startAgent = true;

  # List services that you want to enable:
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    # Required for udiskie
    udisks2.enable = true;
    # D-Bus and FUSE communication library
    gvfs.enable = true;
    # Network devices surveillance
    devmon.enable = true;
    # Keyboard options
    xserver.xkb.layout = "br";
  };

  # Tell electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
