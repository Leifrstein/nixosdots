{...}: {
  networking = {
    firewall = {
      enable = true;
      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;
      trustedInterfaces = ["virbr0"];
      allowedTCPPorts = [
        9090 # Calibre port
        9100 # Printing port
        21027 # Syncthing
        22000 # Syncthing
      ];
      allowedUDPPorts = [
        9090 # Calibre port
        9100 # Printing port
        21027 # Syncthing
        22000 # Syncthing
      ];
    };
    nftables.enable = true;
  };
}
