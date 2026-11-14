lib: config:
{
  path,
  description,
  moduleConfig,
  options ? { },
}:
let
  listPath = [ "modules" ] ++ (lib.splitString "." path);
  enableOption = { enable = lib.mkEnableOption description; };
  otherOptions = builtins.mapAttrs (name: value: lib.mkOption value) options;
  allOptions = enableOption // otherOptions;
  allOptionsWithPath = lib.setAttrByPath (["options"] ++ listPath) allOptions;
in
allOptionsWithPath
// {
  config = lib.mkIf (lib.getAttrFromPath (listPath ++ [ "enable" ]) config) moduleConfig;
}
