{pkgs, ...}: {
  systemd.user.services = {
    # Enable with systemctl --user enable luduludusavi-backup
    "ludusavi-backup" = {
      # Check log with journalctl -u ludusavi-backup.service / journalctl -b
      Unit = {
        Description = "Ludusavi backup";
        After = "network.target";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.ludusavi}/bin/ludusavi backup --force";
      };
      Install = {WantedBy = ["default.target"];};
    };
  };
  systemd.user.timers = {
    "ludusavi-backup" = {
      Unit = {Description = "Ludusavi backup timer";};
      Timer = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "ludusavi-backup.service";
      };
      Install = {WantedBy = ["timers.target"];};
    };
  };
}
