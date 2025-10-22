{...}: {
  home.file.".config/pipewire/pipewire.conf" = {
    text = ''
      context.properties = {
      	default.clock.rate = 48000
      	default.clock.allowed-rates = [48000]
      	default.clock.quantum = 800
      	default.clock.min-quantum = 512
      	default.clock.max-quantum = 1024
      }
    '';
  };
  home.file.".config/pipewire/pipewire-pulse.conf" = {
    text = ''
      pulse.properties = {
      	pulse.min.req = 512/48000
      	pulse.default.req = 800/48000
      	pulse.min.quantum = 510/48000
      }
    '';
  };
}
