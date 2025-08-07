{
  disk,
  memory,
}: {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = disk;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["defaults"];
            };
          };
          nixos = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-f"]; # Override existing partition
              # Subvolumes must set a mountpoint in order to be mounted,
              # unless their parent is mounted
              subvolumes = let
                mountOptions = [
                  "compress-force=zstd:1"
                  "noatime"
                  "nodiratime"
                  "discard"
                ];
              in {
                "/nix" = {
                  inherit mountOptions;
                  mountpoint = "/nix";
                };
                "/persist" = {
                  inherit mountOptions;
                  mountpoint = "/persist";
                };
                "/log" = {
                  inherit mountOptions;
                  mountpoint = "/var/log";
                };
                # Subvolume for the swapfile
                "/swap" = {
                  mountpoint = "/.swap";
                  swap = {
                    swapfile.size = memory;
                  };
                };
              }; # Subvolumes
            };
          }; # Main partition
        }; # Partitions
      };
    }; # Disk
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "mode=755"
      ];
    };
  };
  fileSystems."/var/log".neededForBoot = true;
}
