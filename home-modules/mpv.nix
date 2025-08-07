{
  config,
  pkgs,
  ...
}: {
  programs.mpv = let
    fonts = config.stylix.fonts;
  in {
    enable = true;
    config = {
      osd-font = fonts.sansSerif.name;
      osd-fractions = true;
      osd-bar = "no";
      border = "no";
    };

    profiles = {
      eye-cancer = {
        sharpen = 5;
        osd-font = "Comic Sans MS";
      };
    };

    scripts = with pkgs.mpvScripts; [
      mpris
      autosubsync-mpv
      autoload
      autosub
      autosubsync-mpv
      eisa01.smartskip
      eisa01.undoredo
      eisa01.simplehistory
      eisa01.simplebookmark
      eisa01.smart-copy-paste-2
      mpv-discord
      mpv-cheatsheet
      uosc
      thumbfast
    ];

    scriptOpts = {
      console.font = fonts.monospace.name;
      osc.seekbarstyle = "diamond";
    };
  };
  #home.packages = [
  #  pkgs.ffsubsync
  #];
}
