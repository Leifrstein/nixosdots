{...}: {
  imports = [
    # xterm uses colours from xresources
    ./xresources.nix
  ];

  config = {
    xresources.properties = {
      "XTerm*faceName" = "Ubuntu Nerd Font,Ubuntu Nerd Font Semibold";
    };
  };
}
