{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        vhostUserPackages = with pkgs; [virtiofsd];
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    spice
    spice-gtk
    spice-protocol
    virt-viewer
    virtio-win
    win-spice
  ];

  #users.groups.libvirtd.members = ["leifrstein"];
}
