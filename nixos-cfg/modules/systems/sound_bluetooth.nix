{
  pkgs,
  ...
}:

{
  # Enable sound and Bluetooth.
  # services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    systemWide = false;

  };

  security.rtkit.enable = true;
  systemd.services.mpd.serviceConfig.SupplementaryGroups = [ "pipewire" ];
  environment.systemPackages = with pkgs; [
    easyeffects
  ];
}
