lib: path:
builtins.readDir path
|> builtins.mapAttrs (
  name: value:
  if value == "directory" then
    path + ("/" + name + "/default.nix")
  else if value == "regular" && (lib.hasSuffix ".nix" name) && (name != "default.nix") then
    path + ("/" + name)
  else
    0
)
|> builtins.attrValues
|> builtins.filter (value: value != 0)
