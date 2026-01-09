{ pkgs, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      dockerCompat = true;
      dockerSocket.enable = true;

      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      containers = {
        database = {
          image = "postgres:16-alpine";
          ports = [ "5432:5432" ];
          environment = {
            POSTGRES_USER = "steve";
            POSTGRES_PASSWORD = "password";
            POSTGRES_DB = "app";
          };
          volumes = [
            "/var/lib/postgresql/data:/var/lib/postgresql/data"
          ];
        };

        meilisearch = {
          image = "getmeili/meilisearch:latest";
          ports = [ "7700:7700" ];
          environment = {
            MEILI_ENV = "development";
            MEILI_MASTER_KEY = "masterKey";
          };
          volumes = [
            "/var/lib/meili-data:/meili_data"
          ];
        };
      };
    };
  };
}
