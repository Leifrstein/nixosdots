{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    plugins = let
      writePlugin = text:
        pkgs.writeTextFile rec {
          inherit text;
          name = "init.lua";
          destination = "/${name}";
        };
    in {
      # Snippets
      "arrow" =
        writePlugin
        # lua
        ''
          --- @sync entry
          return {
            entry = function(_, job)
              local current = cx.active.current
              local new = (current.cursor + job.args[1]) % #current.files
              ya.manager_emit("arrow", { new - current.cursor })
            end,
          }
        '';
      "smart-paste" =
        writePlugin
        # lua
        ''
          --- @sync entry
          return {
            entry = function()
              local h = cx.active.current.hovered
              if h and h.cha.is_dir then
                ya.manager_emit("enter", {})
                ya.manager_emit("paste", {})
                ya.manager_emit("leave", {})
              else
                ya.manager_emit("paste", {})
              end
            end,
          }
        '';
    };
    settings = {
      plugin = {
        prepend_previewers =
          [
            {
              name = "*.md";
              run = "glow";
            }
            {
              mime = "audio/*";
              run = "exifaudio";
            }
          ]
          ++ (
            builtins.map
            (type: {
              mime = "application/${type}";
              run = "ouch";
            })
            [
              "*zip"
              "x-tar"
              "x-bzip2"
              "x-7z-compressed"
              "x-rar"
              "x-xz"
            ]
          );
      };
      opener.open = [
        {
          run = ''xdg-open "$1"'';
          desc = "Open";
          orphan = true; # Ensure it stays open after yazi is closed
        }
      ];
    };
    keymap = {
      input.prepend_keymap = [
        {
          on = ["<Esc>"];
          run = "close";
          desc = "Cancel input";
        }
      ];
      manager.prepend_keymap =
        [
          {
            on = ["l"];
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = ["p"];
            run = "plugin smart-paste";
            desc = "Paste into the hovered directory or CWD";
          }
          {
            on = ["<C-n>"];
            run = ''shell '${lib.getExe pkgs.dragon-drop} --and-exit --all --on-top "$@"' --confirm'';
            desc = "Drag and drop selected files with dragon";
          }
          {
            on = ["k"];
            run = "plugin arrow --args=-1";
            desc = "Move cursor up (wrapping)";
          }
          {
            on = ["j"];
            run = "plugin arrow --args=1";
            desc = "Move cursor down (wrapping)";
          }
        ]
        ++ (builtins.genList (
            x: let
              i = toString (x + 1);
            in {
              on = ["${i}"];
              run = "plugin relative-motions --args=${i}";
              desc = "Move in relative steps";
            }
          )
          9);
    };
  };

  # Dependencies for plugins
  home.packages = with pkgs; [
    # Previewers
    glow
    exiftool
    ouch
  ];
}
