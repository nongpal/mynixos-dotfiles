{
  pkgs,
  config,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    mpd
    ncmpcpp
    flac
  ];
  # Music
  services.mpd = {
    enable = true;
    musicDirectory = "/home/nongpal/Music/";
    user = "nongpal";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire output"
      }
    '';
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.nongpal.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };
}
