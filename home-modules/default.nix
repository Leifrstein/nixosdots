{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: {
  # Import all nix files in directory
  # Should ignore this file and all non-nix files
  # Currently, all non-nix files and dirs here are hidden dotfiles
  imports = map (file: ./. + "/${file}") (
    lib.strings.filter (file: !lib.strings.hasPrefix "." file && file != "default.nix") (
      builtins.attrNames (builtins.readDir ./.)
    )
  );

  home = {
    homeDirectory = "/home/${config.home.username}";
    packages = with pkgs; [
      itd
      killall
      brightnessctl
      playerctl
      #xdg-desktop-portal
      #xdg-desktop-portal-gnome
      #xdg-desktop-portal-gtk
      #pavucontrol
      #lxqt.pavucontrol-qt
      flameshot
      grim
      slurp
      pwvucontrol
      qalculate-gtk
      gammastep
      numbat
      hardinfo2
      lm_sensors
      swww
      strawberry
      tree
      tuxpaint
      wl-clipboard
      telegram-desktop
      ntfs3g
      qbittorrent
      nicotine-plus
      system-config-printer
      #onlyoffice-bin
      calibre
      zotero
      gimp
      geany
      #swaynotificationcenter
      mako
      waybar
      inkscape
      syncplay
      yt-dlp
      obs-studio
      ffmpeg
      movit
      mediainfo
      libmediainfo
      tenacity
      imagemagick
      qgis
      texinfo
      newsboat
      timer
      ripgrep-all
      rsync
      hwinfo
      pciutils
      dua
      gparted
      nautilus
      nautilus-open-any-terminal
      xarchiver
      sushi
      jq
      #woeusb
      usbimager
      logseq
      filezilla
    ];

    sessionVariables = {
      # Some things require $EDITOR to be a single command with no args
      EDITOR = "xdg-open";
      VISUAL = "$EDITOR";
      PAGER = "bat";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --plain --language=man'";
    };

    # DON'T TOUCH
    # Use system-level stateVersion
    stateVersion = osConfig.system.stateVersion;
  };

  programs = {
    nix-index.enable = true; # Database for command not found in shell
    dircolors.enable = true; # Color ls output
    home-manager.enable = true; # lets Home Manager manage itself
  };

  services = {
    cliphist.enable = true;
    syncthing = {
      enable = true;
      # tray.enable = true;
    };
    playerctld.enable = true;
  };

  systemd.user.tmpfiles.rules = ["L ${config.home.homeDirectory}/nixos - - - - /etc/nixos"];
}
