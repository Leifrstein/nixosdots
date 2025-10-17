{ config, ... }:
{
  flake.meta.gitHubUsername = "Leifrstein";

  unify.modules.general.home.programs.git = {
    enable = true;
    userEmail = "lucaspc@pm.me";
    userName = config.flake.meta.gitHubUsername;
    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = "input";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
  };
}
