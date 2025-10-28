{
  pkgs,
  ...
}:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-ocl
        intel-media-driver
        vulkan-loader
        vulkan-tools
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        intel-media-driver
      ];
    };
  };
}
