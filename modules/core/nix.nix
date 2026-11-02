{
  helpers,
  config,
  inputs,
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
    nix.registry.templates.flake = inputs.nix-templates;
    nixpkgs.config.allowUnfree = true;
  };
}
