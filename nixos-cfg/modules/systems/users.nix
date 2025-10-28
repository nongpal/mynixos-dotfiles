{
  pkgs,
  ...
}:

{
  users = {
    users = {
      nongpal = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "pipewire"
        ];
        shell = pkgs.fish;
        packages = with pkgs; [
          tree
          bat
        ];
      };
    };
  };
}
