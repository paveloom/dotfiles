{config, ...}: {
  home.stateVersion = "23.11";

  services = {
    gnome-keyring = {
      components = ["pkcs11" "secrets" "ssh"];
      enable = true;
    };
  };

  systemd.user.services.gnome-keyring.Install.WantedBy = ["default.target"];

  xdg = {
    configFile = let
      configPath = dir: (config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/Repositories/paveloom/dotfiles/.config/${dir}");
    in {
      "Code".source = configPath "Code";
      "MangoHud".source = configPath "MangoHud";
      "ccache".source = configPath "ccache";
      "direnv".source = configPath "direnv";
      "emacs".source = configPath "emacs";
      "fish".source = configPath "fish";
      "gdb".source = configPath "gdb";
      "git".source = configPath "git";
      "helix".source = configPath "helix";
      "ideavim".source = configPath "ideavim";
      "lazygit".source = configPath "lazygit";
      "mozc".source = configPath "mozc";
      "mpv".source = configPath "mpv";
      "nvim".source = configPath "nvim";
      "pdm".source = configPath "pdm";
      "task".source = configPath "task";
      "wezterm".source = configPath "wezterm";
      "yamlfmt".source = configPath "yamlfmt";
      "yamllint".source = configPath "yamllint";
    };
  };
}
