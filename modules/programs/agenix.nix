{
  config,
  helpers,
  lib,
  agenixRegistry,
  ...
}:
let
  privateKeyDefinitions = builtins.mapAttrs (name: value: value.private) agenixRegistry.keys;
in
helpers.mkOptionalModule config {
  path = "programs.agenix";
  description = "Enable Agenix";
  options = {
    enabledKeys = {
      type = with lib.types; listOf str;
      description = "List of enabled key names";
      default = [ ];
    };
  };
  moduleConfig = {
    age.secrets = lib.attrsets.filterAttrs (
      name: value: builtins.elem name config.modules.programs.agenix.enabledKeys
    ) privateKeyDefinitions;
  };
}
