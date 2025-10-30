{
  pkgs,
  ...
}:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.neovim-unwrapped;
    };

    git = {
      enable = true;
    };

    lazygit = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnumake
    fasm
    raylib
  ];
}
