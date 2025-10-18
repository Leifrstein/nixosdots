# dotfiles
My personal dotfiles for NixOS

# Usage:
Run the following command from a NixOS installation medium:

```bash
sudo nix --extra-experimental-features "nix-command flakes pipe-operators" run github:Leifrstein/nixosdots#install
```

I highly recommend that you thoroughly read `scripts/install.nix` BEFORE running it so that you know what it will do in advance.
