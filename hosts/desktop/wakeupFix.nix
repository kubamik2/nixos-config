inputs: {
  systemd.services.wakeup-fix = {
    script = ''
      echo "disabled" > /sys/devices/pci0000\:00/0000\:00\:01.1/power/wakeup
    '';
    wantedBy = [ "multi-user.target" ];
  };
}
