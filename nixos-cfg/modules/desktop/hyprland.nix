{
  pkgs,
  ...
}:

{
  services.libinput.enable = true;
  services.xserver.enable = false;
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        openssl
        zlib
      ];
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
    yazi.enable = true;
    fish.enable = true;
    waybar.enable = true;

    bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  fonts.packages = with pkgs; [
    maple-mono.NF
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    ghostty
    fuzzel
    fastfetch
    dunst
    btop
    cbonsai
    grim
    grimblast
    bibata-cursors
    # starship
  ];
}
