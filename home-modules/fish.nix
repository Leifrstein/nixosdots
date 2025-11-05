{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    fish = {
      enable = true;
      functions = {
        fish_greeting = let
          lolcat = lib.getExe pkgs.lolcat;
        in
          # fish
          ''
            # Ascii Terminal greeting.
            # Shows Linux distro and version in rainbow ascii art.
            echo -en "\e[1m"
            ${lib.getExe pkgs.lsb-release} --description --short |
              tr --delete '"' |
              ${lib.getExe pkgs.toilet} \
                --termwidth \
                --font smslant \
                --filter border \
                --directory ${pkgs.figlet}/share/figlet |
                ${lolcat}
            echo -e "\e[1m Welcome back, $USER!\e[0m" |
              ${lolcat}
          '';
        fish_user_key_bindings =
          # fish
          ''
            # Vi keybindings
            fish_vi_key_bindings

            # Make Ctrl+Z also bring program to foreground
            bind \cz -M insert 'fg 2>/dev/null; commandline -f repaint'
          '';
      };
      interactiveShellInit =
        # fish
        ''
          # Use fish for `nix develop`
          ${lib.getExe pkgs.nix-your-shell} fish | source
        '';
      shellInit =
        # fish
        ''
          # Initialize batpipe
          eval (batpipe)

          # fzf-fish settings
          # width=20 so delta decorations don't wrap around small fzf preview pane
          # also disable side-by-side
          set -g fzf_diff_highlighter DELTA_FEATURES="+" delta --paging=never --width=20
        '';
      shellAbbrs = {
        # Pipe every command run with --help through bat
        "--help" = {
          position = "anywhere";
          expansion = "--help | bat --plain --language=help";
        };
      };
      shellAliases = {
        rd = "rmdir";
        md = "mkdir";
        rm = "rm --interactive";
        du = lib.getExe pkgs.dust;
        df = lib.getExe pkgs.duf;
        fd = "fd -Lu";
        w3m = "w3m -no-cookie -v";
        ls = "eza --icons -l -T -L=1";
        # bat
        #bgrep = "batgrep";
        cat = "bat --paging=never";
        less = "bat --paging=always";
        man = "batman";
        diff = "batdiff";
        # tealdeer
        tldr = "PAGER='bat --plain' command tldr";
        # lazygit
        lg = "lazygit";
        # system rebuild
        nhs = "cd /home/leifrstein/nixos && sudo nixos-rebuild switch --flake .";
        nhb = "cd /home/leifrstein/nixos && sudo nixos-rebuild boot --flake .";
        nhd = "cd /home/leifrstein/nixos && sudo nixos-rebuild dry-activate --flake .";
        # generation management
        gc-clean = "nix-collect-garbage --delete-older-than 10d";
        sgc-clean = "sudo nix-collect-garbage --delete-older-than 10d";
        list-generations = "nix-env -p ~/.local/state/nix/profiles/home-manager --list-generations";
        slist-generations = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      };
      plugins = (
        map
        (name: {
          inherit name;
          src = pkgs.fishPlugins."${name}".src;
        })
        [
          "autopair"
          "done"
          "fish-bd"
          "fish-you-should-use"
          "fzf-fish"
          "grc"
          "plugin-sudope"
        ]
      );
    };
    ripgrep.enable = true;
    fd.enable = true;
  };

  # Needed for plugins
  home.packages = with pkgs; [
    libnotify # Needed for done
    grc # Needed for grc
  ];
}
