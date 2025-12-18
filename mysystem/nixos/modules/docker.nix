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

  environment.systemPackages = with pkgs; [docker-compose];
}
