{
  helpers,
  config,
  ...
}:
helpers.mkOptionalModule config {
  path = "core.nix";
  description = "Enable core nix config";
  moduleConfig = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
