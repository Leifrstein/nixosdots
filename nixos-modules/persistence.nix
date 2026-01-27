{config, ...}: {
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # Necessary system state
      ## NixOS
      "/var/lib/nixos" # Holds state needed for stable uids and gids for users and groups
      ## systemd
      "/var/lib/systemd" # Systemd state directory, used for numerous things
      # Other important things
      "/etc/NetworkManager/system-connections" # Network connections
      "/var/lib/bluetooth" # Bluetooth connections
      "/var/lib/clamav" # ClamAV signature database
      #"/var/lib/flatpak"
      "/var/lib/qbittorrent" # qBittorrent state
      "/var/lib/libvirt"
      "/tmp" # Persist tmp so it's not mounted on tmpfs and ensure there's enough space for rebuilds, it'll be cleaned by setting boot.tmp.cleanOnBoot to true
      # Nix config
      rec {
        directory = "/etc/nixos";
        user = "leifrstein";
        group = config.users.users.${user}.group;
      }
    ];
    files = [
      # Necessary system state
      ## systemd
      "/etc/machine-id" # Unique system id for logging, etc.
    ];
    users.leifrstein = {
      directories = [
        # Default directories I care about
        "Documents"
        "Downloads"
        "Books"
        "Cloud"
        "Games"
        "Music"
        "Pictures"
        "Videos"
        "VM"

        # Gaming-specific stuff
        ".cache/lutris" # Lutris banner cache
        ".config/lutris" # Lutris games and settings
        ".config/unity3d" # Needed for some games' settings
        ".config/0ad" # 0 A.D. configuration
        ".config/obs-studio" # OBS configuration
        ".local/share/lutris" # Lutris runtime data
        ".local/share/bottles" # Bottles runtime data
        ".local/share/PrismLauncher" # Prism Launcher data
        ".local/share/Steam" # Steam games and save data
        ".local/share/0ad" # 0 A.D. save data
        ".klei" # Don't Starve Together data
        ".xlcore" # Final Fantasy XIV data

        # Other important stuff
        ".config/calibre" # Calibre data
        ".config/ludusavi" # ludusavi configuration
        ".config/mpv" # MPV scripts and history
        ".config/qBittorrent" # qBittorrent configuration
        ".local/share/qBittorrent" # qBittorrent state
        ".config/geany" # Geany IDE configuration
        ".local/bin" # Misc binaries
        ".local/share/applications" # AppImage misc.
        ".local/share/keyrings" # Gnome Keyrings
        ".local/share/nautilus" # Nautilus state
        ".local/share/TelegramDesktop" # Telegram account data
        ".local/state/gitui"
        ".local/state/wireplumber"
        ".mozilla" # Firefox data
        ".librewolf" # Librewolf data
        "Sync" # Syncthing
        ".tuxpaint" # Tux Paint saves
        # SSH key
        {
          directory = ".ssh";
          mode = "u=rwx,g=,o=";
        }

        # Non-critical caches and data to persist
        ".cache/spotify" # Spotify cache
        ".cache/tealdeer" # Tldr pages, prevents tealdeer redownloading them every time
        ".config/MangoHud" # MangoHud
        ".config/GIMP" # GIMP settings
        ".config/LanguageTool" # LanguageTool settings
        ".config/libreoffice" # Libreoffice settings
        ".config/spotify" # Spotify user data
        ".config/strawberry" # Strawberry settings
        #".config/equibop/sessionData" # Equibop user data
        ".config/vesktop/sessionData" # Vesktop user data
        ".config/StardewValley" # Stardew Valley data
        ".local/share/strawberry" # Strawberry cache
        ".local/share/zathura" # Zathura bookmarks, etc.
        ".local/share/zoxide" # Zoxide history
        ".local/state/syncthing" # Syncthing settings
      ];
      files = [
        ".config/gtk-3.0/bookmarks" # Nautilus bookmarks
      ];
    };
  };
  boot.tmp.cleanOnBoot = true; # Cleans the persisted tmp on boot
  # Needed for root to access bind mounted dirs created by impermanence
  programs.fuse.userAllowOther = true;
}
