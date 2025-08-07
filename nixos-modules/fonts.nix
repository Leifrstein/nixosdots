{pkgs, ...}: {
  fonts.packages = with pkgs; [
    # Fonts
    nerd-fonts.victor-mono
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.ubuntu
    nerd-fonts.iosevka
    nerd-fonts.fira-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.liberation
    nerd-fonts.inconsolata
    nerd-fonts.roboto-mono
    nerd-fonts.recursive-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fantasque-sans-mono
  ];
}
