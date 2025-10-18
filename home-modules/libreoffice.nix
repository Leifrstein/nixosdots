{pkgs, ...}: {
  home.packages = with pkgs; [
    aspell # Required for spellcheck
    aspellDicts.en # English spellcheck dictionary
    aspellDicts.pt_BR # Brazilian Portuguese spellcheck dictionary
    aspellDicts.fr # French spellcheck dictionary
    languagetool # spelling, style and grammar checker
    libreoffice-fresh
  ];
}
