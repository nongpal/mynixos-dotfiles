{
  lib,
  pkgs,
  ...
}:

{
  security = {
    rtkit = {
      enable = true;
    };
    sudo = {
      enable = true;
      extraConfig = with pkgs; ''
        Defaults:picloud secure_path="${
          lib.makeBinPath [
            systemd
          ]
        }:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
      '';
      extraRules = [
        {
          commands = [
            {
              command = "${pkgs.systemd}/bin/systemctl suspend";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/reboot";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/poweroff";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }
      ];
    };
  };
}
