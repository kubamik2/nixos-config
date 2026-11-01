{
  helpers,
  config,
  ...
}:
helpers.mkOptionalModule config {
  path = "core.keymap";
  description = "Enable core keymap config";
  moduleConfig = {
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "pl";
      variant = "";
    };

    console.keyMap = "pl2";
  };
}
