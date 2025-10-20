{...}: {
# Reminder to backup the key required to push. After fresh install, put it in .ssh and navigate to the dotfiles to do git push and finish setup.
  programs = {
    git = {
      enable = true;
      user = {
        email = "lucaspc@pm.me";
        name = "Lucas";
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        interactive.keep-plus-minus-markers = false;
      };
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = "input";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
    lazygit = {
      enable = true;
      settings = {
        theme.nerdFontsVersion = 3;
        update.method = false;
        disableStartupPopups = true;
        git = let
          logCmd = "git log --color=always";
        in {
          paging = {
            colorArg = "always";
            pager = ''DELTA_FEATURES="+" delta --paging=never'';
          };
          branchLogCmd = "${logCmd} {{branchName}}";
          allBranchesLogCmds = ["${logCmd} --all"];
        };
      };
    };
  };

  home.sessionVariables = {
    # Ensure bat's line numbers don't show up and mess things up
    DELTA_PAGER = "bat --plain";
    # Ensure --side-by-side is only used for `git diff`
    DELTA_FEATURES = "+side-by-side";
  };
}
