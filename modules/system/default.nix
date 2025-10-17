{
  unify.modules.general.nixos = {pkgs, ...}: {
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    time.timeZone = "America/Sao_Paulo";
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_CTYPE = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
      LC_COLLATE = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_MESSAGES = "en_GB.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
    };
    # use xkbOptions in tty.
    console.useXkbConfig = true;
  };
}
