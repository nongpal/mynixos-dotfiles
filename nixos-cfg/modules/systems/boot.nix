{
  pkgs,
  ...
}:

{
  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = false;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      limine = {
        enable = true;
        efiSupport = true;
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "coretemp" ];

    initrd.kernelModules = [
      "i915"
      "nvidia"
    ];
  };
}
