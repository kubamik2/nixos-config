{
  config,
  helpers,
  inputs,
  ...
}:
helpers.mkOptionalModule config {
  path = "programs.neovim";
  description = "Enable Neovim";
  moduleConfig = {
    environment = {
      systemPackages = [ inputs.nixvim-config.packages.x86_64-linux.default ];
      variables.EDITOR = "nvim";
    };
  };
}
