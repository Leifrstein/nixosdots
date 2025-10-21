{
 config,
 lib,
 pkgs,
  ...
}: {
  programs.niri.settings = let
    launch = mime: [
      "handlr"
      "launch"
      mime
      "--"
    ];
    terminal = launch "x-scheme-handler/terminal";
    palette =
      (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
      .${config.catppuccin.flavor}
      .colors;
    accent = palette.${config.catppuccin.accent}.hex;
    workspaces = 10;
  in {
    # Prefer no client-side decorations to make borders and rounded corners a bit more consistent
    prefer-no-csd = true;

    # Needed for xwayland-satellite
    environment.DISPLAY = ":0";

    hotkey-overlay.skip-at-startup = true;

    input = {
      warp-mouse-to-focus.enable = true;
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "95%";
      };
      keyboard.xkb = {
        # See xkeyboard-config(7) for options
        layout = "br";
        #variant = "colemak";
        #options = "caps:escape_shifted_capslock";
      };
    };

    outputs = {
      DP-2 = {
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 144.000;
        };
        variable-refresh-rate = true;
      };
      DP-3 = {
        position = {
          x = 1920;
          y = 0;
        };
      };
    };

    layout = {
      gaps = 5;
      preset-column-widths = [
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
      ];
      default-column-width.proportion = 1. / 2.;
      always-center-single-column = true;

      focus-ring = {
        width = 2;
        active.gradient = {
          from = accent;
          to = palette.lavender.hex;
          angle = 45;
          relative-to = "workspace-view";
          in' = "oklch longer hue";
        };
      };
    };

    window-rules = [
      {
        # Lets clients without xdg-decoration protocols have transparent backgrounds
        draw-border-with-background = false;
        # Rounded corners
        #geometry-corner-radius = let
        #  radius = 12.0;
        #in {
        #  bottom-left = radius;
        #  bottom-right = radius;
        #  top-left = radius;
        #  top-right = radius;
        #};
        #clip-to-geometry = true;
        # Open clients to take up maximum space by default
        open-maximized = true;
      }
      {
        matches = [
          {app-id = "^org.pulseaudio.pavucontrol$";}
          {app-id = "^com.terminal.nmtui$";}
        ];
        open-floating = true;
      }
    ];

    spawn-at-startup = [
      {command = [(lib.getExe pkgs.xwayland-satellite)];}
      {
        command = ["wpaperd"];
      }
      {
        command = [
          "steam"
          "-silent"
        ];
      }
      {
        command = ["qbittorrent"];
      }
      {
	    command = ["mako"];
	  }
	  #{
		#command = ["swaync"];
	  #}
    ];

    binds = let
      inherit (config.lib.niri) actions;
      wpctl = args: {
        allow-when-locked = true;
        action.spawn = ["wpctl"] ++ args;
      };
      mouse = action: {
        cooldown-ms = 150;
        inherit action;
      };
      sh = actions.spawn "sh" "-c";
    in
      {
        "Mod+Shift+Slash".action = actions.show-hotkey-overlay;

        "Mod+T".action.spawn = terminal;
        "Mod+D".action = sh "pkill fuzzel || fuzzel";
        "Mod+O".action.spawn = launch "x-scheme-handler/https";
        #"Mod+N".action.spawn = sh "swaync-client" "-t";
        "Mod+Shift+W".action = sh "systemctl --user restart waybar.service";
        "Mod+G".action.spawn = launch "inode/directory";
        "Super+Alt+L".action = actions.spawn "wlogout" "--show-binds";
        "Mod+Ctrl+C".action = sh "cliphist list | fuzzel --dmenu --prompt='Copy to Clipboard:' | wl-copy";

        # Volume keys mappings for PipeWire & WirePlumber.
        XF86AudioRaiseVolume = wpctl [
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1+"
        ];
        XF86AudioLowerVolume = wpctl [
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1-"
        ];
        XF86AudioMute = wpctl [
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        XF86AudioMicMute = wpctl [
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];

        # Close focused window.
        "Mod+Q".action = actions.close-window;

        # Change window/column focus
        "Mod+H".action = actions.focus-column-left-or-last;
        "Mod+J".action = actions.focus-window-down;
        "Mod+K".action = actions.focus-window-up;
        "Mod+L".action = actions.focus-column-right-or-first;
        "Mod+Left".action = actions.focus-column-left-or-last;
        "Mod+Down".action = actions.focus-window-down;
        "Mod+Up".action = actions.focus-window-up;
        "Mod+Right".action = actions.focus-column-right-or-first;
        "Mod+Home".action = actions.focus-column-first;
        "Mod+End".action = actions.focus-column-last;

        # Move window/column
        "Mod+Shift+H".action = actions.move-column-left;
        "Mod+Shift+J".action = actions.move-window-down;
        "Mod+Shift+K".action = actions.move-window-up;
        "Mod+Shift+L".action = actions.move-column-right;
        "Mod+Shift+Left".action = actions.move-column-left;
        "Mod+Shift+Down".action = actions.move-window-down;
        "Mod+Shift+Up".action = actions.move-window-up;
        "Mod+Shift+Right".action = actions.move-column-right;
        "Mod+Ctrl+Home".action = actions.move-column-to-first;
        "Mod+Ctrl+End".action = actions.move-column-to-last;

        # Change workspace focus
        "Mod+Page_Down".action = actions.focus-workspace-down;
        "Mod+Page_Up".action = actions.focus-workspace-up;
        "Mod+WheelScrollDown" = mouse actions.focus-workspace-down;
        "Mod+WheelScrollUp" = mouse actions.focus-workspace-up;

        # Move workspace
        "Mod+Ctrl+Page_Down".action = actions.move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = actions.move-column-to-workspace-up;
        "Mod+Shift+Page_Down".action = actions.move-workspace-down;
        "Mod+Shift+Page_Up".action = actions.move-workspace-up;
        "Mod+Ctrl+WheelScrollDown" = mouse actions.move-column-to-workspace-down;
        "Mod+Ctrl+WheelScrollUp" = mouse actions.move-column-to-workspace-up;

        "Mod+WheelScrollRight" = mouse actions.focus-column-right-or-first;
        "Mod+WheelScrollLeft" = mouse actions.focus-column-left-or-last;
        "Mod+Ctrl+WheelScrollRight" = mouse actions.move-column-right;
        "Mod+Ctrl+WheelScrollLeft" = mouse actions.move-column-left;

        # Usually scrolling up and down with Shift in applications results in
        # horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown" = mouse actions.focus-column-right-or-first;
        "Mod+Shift+WheelScrollUp" = mouse actions.focus-column-left-or-last;
        "Mod+Ctrl+Shift+WheelScrollDown" = mouse actions.move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp" = mouse actions.move-column-left;

        # Switches focus between the current and the previous workspace.
        "Mod+Tab".action = actions.focus-workspace-previous;

        # Zoom out workspaces for overview
        "Mod+Space".action = actions.toggle-overview;

        # The following binds move the focused window in and out of a column.
        # If the window is alone, they will consume it into the nearby column to the side.
        # If the window is already in a column, they will expel it out.
        "Mod+Comma".action = actions.consume-or-expel-window-left;
        "Mod+Period".action = actions.consume-or-expel-window-right;

        "Mod+R".action = actions.switch-preset-column-width;
        "Mod+Shift+R".action = actions.switch-preset-window-height;
        "Mod+Ctrl+R".action = actions.reset-window-height;
        "Mod+F".action = actions.maximize-column;
        "Mod+Shift+F".action = actions.fullscreen-window;
        "Mod+Ctrl+Shift+F".action = actions.toggle-windowed-fullscreen;
        "Mod+E".action = actions.expand-column-to-available-width;
        "Mod+C".action = actions.center-column;

        # Tabbed column display mode.
        "Mod+W".action = actions.toggle-column-tabbed-display;

        "Mod+Minus".action = actions.set-column-width "-10%";
        "Mod+Equal".action = actions.set-column-width "+10%";

        # Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus".action = actions.set-window-height "-10%";
        "Mod+Shift+Equal".action = actions.set-window-height "+10%";

        # Move the focused window between the floating and the tiling layout.
        "Mod+V".action = actions.toggle-window-floating;
        "Mod+Shift+V".action = actions.switch-focus-between-floating-and-tiling;

        #"Print".action = actions.screenshot;
        #"Print".action = sh "grim -g \'$(slurp)\' - | satty --filename - --output-filename - --copy-command wl-copy";
        #"Ctrl+Print".action = actions.screenshot-screen;
        #"Alt+Print".action = actions.screenshot-window;

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+E".action = actions.quit;
        "Ctrl+Alt+Delete".action = actions.quit;

        "Mod+Shift+P".action = actions.power-off-monitors;
      }
      // lib.mergeAttrsList (
        lib.genList (
          x: let
            workspace = x + 1;
            key = toString (lib.trivial.mod workspace workspaces);
          in {
            "Mod+${key}".action = actions.focus-workspace workspace;
            #"Mod+Ctrl+${key}".action = actions.move-column-to-workspace workspace; # UNCOMMENT WHEN FIXED https://github.com/sodiboo/niri-flake/issues/1018
          }
        )
        workspaces
      );
  };

  # For some reason, the Niri module does not provide this by default
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  # Making sure the portal starts
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    configPackages = [pkgs.niri];
  };
}
