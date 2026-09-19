{
  config,
  helpers,
  ...
}:
helpers.mkOptionalModule config {
  path = "nh";
  description = "Enable nh";
  moduleConfig = {
    programs.nh = {
      enable = true;
      flake = "/home/kubamik2/.config/nixos-config";
    };
  };
}
