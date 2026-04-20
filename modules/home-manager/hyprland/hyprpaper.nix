inputs: {
  services.hyprpaper = {
    enable = true;
    settings = let
      nixos_wallpaper = "/home/kubamik2/myNixOS/assets/wallpapers/gruvbox-nix.png";
    in {
      ipc = "on";
      splash = false;
      preload = [
        ",${nixos_wallpaper}"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "${nixos_wallpaper}";
        }
      ];
    };
  };
}
