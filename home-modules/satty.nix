{...}: {
  home.file.".config/satty/config.toml" = {
    text = ''
      [general]
      copy-command = "wl-copy"
      corner-roundness = 0
      initial-tool = "crop"
      disable-notifications = true

      [font]
      family = "FiraCode Nerd Font"
      style = "Bold"
    '';
  };
}
