{
 lib,
 pkgs,
  ...
}: {
  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      #style = pkgs.lib.readFile ./style.css;
      settings = {
        #
        # ========== Main Bar ==========
        #
        mainBar = {
          layer = "top";
          position = "top";
          #height = 36; # 36 is minimum height required by the modules
          #output = [
          #	"DP-2"
          #	"DP-3"
          #];
          modules-left = [
            "custom/menu"
            "niri/workspaces"
            "mpris"
          ];
          modules-center = [
            "niri/window"
          ];
          modules-right = [
            "pulseaudio"
            "custom/separator"
            "network"
            "custom/separator"
            "cpu"
            "custom/separator"
            "memory"
            "custom/separator"
            "tray"
            "custom/separator"
            "clock"
            #"custom/separator"
            #"custom/swaync"
          ];
          #
          # ========= Modules =========
          #
          "niri/workspaces" = {
            format = "{icon}";
            show-special = true;
            sort-by-name = true;
            format-icons.default = "";
          };
          "niri/window" = {
            format = "{title}";
            icon = true;
            icon-size = 20;
            separate-outputs = true;
            max-length = 40;
          };
          "custom/menu" = {
            format = "  ";
            on-click = "${lib.getExe pkgs.fuzzel} --anchor top-left";
            tooltip = false;
          };
          "custom/separator" = {
            format = " | ";
            interval = "once";
            tooltip = false;
          };
          "mpris" = {
            format = "{player_icon} {status_icon} {dynamic}";
            format-playing = "{player_icon} {status_icon} {dynamic}";
            format-paused = "{player_icon} {status_icon} <i>{dynamic}</i>";
            format-stopped = "{player_icon} {status_icon} <i>{dynamic}</i>";
            dynamic-len = 30;
            player-icons = {
              default = "󰝚";
              firefox = "";
              spotify = "";
            };
            status-icons = {
              playing = "󰐊";
              paused = "󰏤";
              stopped = "󰓛";
            };
          };
          "pulseaudio" = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon}  {format_source}";
            format-bluetooth-muted = " {icon}  {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "󱡏";
              headset = "󰋎";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol-qt";
          };
          "network" = {
            format-wifi = " {signalStrength}%";
            tooltip-format-wifi = "{essid} 󱘖 {gwaddr}";

            format-ethernet = "󰌘";
            tooltip-format-ethernet = "{ifname} 󱘖 {gwaddr}";

            format-linked = "󰌗";
            tooltip-format-linked = "No address";

            format-disconnected = "󰌙";
            tooltip-format-disconnected = "Offline";
          };
          "cpu" = {
            format = "{usage}% ";
            tooltip = false;
          };
          "memory" = {
            format = "{}% ";
          };
          "tray" = {
            icon-size = 14;
            spacing = 8;
          };
          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            interval = 60;
            format = " {:%H:%M} ";
            max-length = 25;
          };

          #"custom/swaync" = {
            #tooltip = true;
            #format = "{icon} {} ";
            #format-icons = {
              #notification = "<span foreground='red'><sup></sup></span>";
              #none = "";
              #dnd-notification = "<span foreground='red'><sup></sup></span>";
              #dnd-none = "";
              #inhibited-notification = "<span foreground='red'><sup></sup></span>";
              #"inhibited-none" = "";
              #"dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
              #"dnd-inhibited-none" = "";
            #};
            #return-type = "json";
            #exec-if = "which swaync-client";
            #exec = "swaync-client -swb";
            #on-click = "sleep 0.1 && swaync-client -t -sw";
            #on-click-right = "swaync-client -d -sw";
            #escape = true;
          #};
        };
      };
      style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;

        * {
        	font-family: Ubuntu Nerd Font;
        	font-size: 14px;
        	min-height: 0;
        }

        #waybar {
        	background: transparent;
        	color: @text;
        	margin: 0.2px 0.2px;
        }

        #workspaces {
        	border-radius: 1rem;
        	margin: 5px;
        	background-color: @surface0;
        	margin-left: 1rem;
        }

        #workspaces button {
        	color: @lavender;
        	border-radius: 1rem;
        	padding: 0.4rem;
        }

        #workspaces button.active {
        	color: @sky;
        	border-radius: 1rem;
        }

        #workspaces button:hover {
        	color: @sapphire;
        	border-radius: 1rem;
        }

        #window,
        #mpris,
        #tray,
        #clock,
        #pulseaudio,
        #network,
        #cpu,
        #memory,
        #custom-notification,

        #window {
        	border-radius: 1rem;
        }

        #mpris {
        	color: @mauve;
        	border-radius: 1rem;
        }

        #clock {
        	color: @green;
        	border-radius: 0px 1rem 1rem 0px;
        }

        #pulseaudio {
        	color: @flamingo;
        	border-radius: 1rem 0px 0px 1rem;
        	margin-left: 1rem;
        }

        #tray {
        	border-radius: 1rem;
        }

        #network {
        	color: @rosewater;
        	border-radius: 1rem;
        }

        #cpu {
        	color: @maroon;
        	border-radius: 1rem;
        }

        #memory {
        	color: @peach;
        	border-radius: 1rem;
        }

        /*#custom-swaync {
        	color: @yellow;
        	border-radius: 1rem;
        }*/
      '';
    };
  };
}
