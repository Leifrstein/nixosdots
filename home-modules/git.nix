{pkgs, ...}: {
  # Reminder to backup the key required to push. After fresh install, put it in .ssh and navigate to the dotfiles to do git push and finish setup.
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "lucaspc@pm.me";
          name = "Lucas";
        };
        init.defaultBranch = "main";
        core.autocrlf = "input";
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
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
    gitui.enable = true;
  };

  home.sessionVariables = {
    # Ensure bat's line numbers don't show up and mess things up
    DELTA_PAGER = "bat --plain";
    # Ensure --side-by-side is only used for `git diff`
    DELTA_FEATURES = "+side-by-side";
    # Merge HM config and user-writable config
  };
}
