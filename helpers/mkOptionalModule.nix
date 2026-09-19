lib: config:
{
  path,
  description,
  moduleConfig,
}:
let
  listPath = [ "modules" ] ++ (lib.splitString "." path) ++ [ "enable" ];
in
(lib.setAttrByPath ([ "options" ] ++ listPath) (lib.mkEnableOption description))
// {
  config = lib.mkIf (lib.getAttrFromPath listPath config) moduleConfig;
}
