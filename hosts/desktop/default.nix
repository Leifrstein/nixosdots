{ config, flake-parts-lib, ... }:
flake-parts-lib.importApply ../_common/host.nix {
  hostname = builtins.baseNameOf ./.;
  modules = with config.unify.modules; [ general ];
  diskoConfig = import ../_common/disko.nix {
    disk = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B7686362AF9";
    memory = "32G";
  };
}
