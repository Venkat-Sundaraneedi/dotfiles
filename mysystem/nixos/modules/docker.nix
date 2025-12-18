{pkgs, ...}: {
  # ┌─────────────────────────────────────┐
  # │       DOCKER CONFIGURATION          │
  # └─────────────────────────────────────┘

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Docker Compose (v2, plugin-based)
  environment.systemPackages = with pkgs; [docker-compose];
}
