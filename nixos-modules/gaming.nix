{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      # Add extra compatibility tools to Steam
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };
    # On-demand system optimization for gaming
    gamemode.enable = true;
  };

  # Support Direct Rendering for 32-bit applications, like Wine
  hardware.graphics.enable32Bit = true;

  # nix-gaming cache
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  environment.systemPackages = with pkgs; [
	xivlauncher
  ];

  # Game launch options
  #Online-fix games: WINEDLLOVERRIDES="OnlineFix64=n;SteamOverlay64=n;winmm=n,b;dnet=n;steam_api64=n;winhttp=n,b" %command%
  #Trails in the Sky: WINEDLLOVERRIDES=DINPUT8=n,b %command%
  #Baldur's Gate 3: WINEDLLOVERRIDES="DWrite.dll=n,b" PROTON_NO_ESYNC=1 %command% --skip-launcher
  #Resident Evil 4 (if using mods): WINEDLLOVERRIDES="dinput8.dll=n,b" %command%

  #services.logmein-hamachi.enable = true;
}
