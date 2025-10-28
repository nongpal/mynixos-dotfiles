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
}
