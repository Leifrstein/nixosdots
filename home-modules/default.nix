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
      image-roll
      tauon
      mpd
      rmpc
      cozy
      tree
      wl-clipboard
      telegram-desktop
      ntfs3g
      qbittorrent
      nicotine-plus
      system-config-printer
      calibre
      zotero
      gimp
      geany
      mako
      waybar
      inkscape
      syncplay
      yt-dlp
      ffmpeg
      movit
      mediainfo
      libmediainfo
      #tenacity reenable when fix reaches unstable https://github.com/NixOS/nixpkgs/issues/475574
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
      logseq
      filezilla
      p7zip
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
  
  # Add to PATH
  home.sessionPath = ["$HOME/.local/bin"];

  services = {
    cliphist.enable = true;
    syncthing = {
      enable = true;
      # tray.enable = true;
    };
    playerctld.enable = true;
  };

	systemd.user.tmpfiles.rules = [
    # Create a link to /etc/nixos, where the config is in the home directory
    "L ${config.home.homeDirectory}/nixos - - - - /etc/nixos"
    # Ensure SSH keys have proper permissions.
    # NOTE: persistence permissions only seem to apply upon creating a bind mount
    # NOTE: Directory and contents need to have permissions set separately or else it gets set to root permissions for some reason
    "z ${config.home.homeDirectory}/.ssh 0700 ${config.home.username} users - -"
    "Z ${config.home.homeDirectory}/.ssh/* 0600 ${config.home.username} users - -"
  ];
}
