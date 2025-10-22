{pkgs, ...}: {
  # Needed for pipewire to work in real time
  security.rtkit.enable = true;
  
  # Give pipewire real-time priority to improve latency
  environment.etc."security/limits.d/99-pipewire.conf".text = ''
    @pipewire - rtprio 95
    @pipewire - memlock unlimited
    @pipewire - nice -19
  '';

  # Enable sound.
  services = {
    # Disable pulseaudio in order to use pipewire
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      lowLatency.enable = true;
      wireplumber = {
        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
            wireplumber.settings = { bluetooth.autoswitch-to-headset-profile = false }
          '')
        ];
        extraConfig = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = false;
            "bluez5.hfphsp-backend" = "none";
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [
              "a2dp_sink"
              "a2dp_source"
            ];
            "bluez5.codecs" = [
              "ldac"
              "aptx_hd"
              "aptx"
              "aac"
              "sbc_xq"
              "sbc"
            ];
          };
        };
      };
    };
  };
}
