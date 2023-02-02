{
  config,
  pkgs,
  sops-nix,
  ...
}: {
  # Define the default Sops file
  sops.defaultSopsFile = ./secrets.yaml;

  # Use the `age` key to decrypt
  sops.age.keyFile =
    config.users.users.paveloom.home + "/.config/sops/age/keys.txt";

  # Place the keys
  sops.secrets.example-key = {
    owner = config.users.users.paveloom.name;
  };
}
