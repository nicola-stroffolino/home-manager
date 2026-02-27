{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.btop.enable = true;

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  imports = [
    ./programs
  ];

  home = {
    stateVersion = "25.05"; # compatibility version
    username = "nstroffo";
    homeDirectory = "/home/nstroffo";

    packages = with pkgs; [
      # Frameworks
      jdk # lts 21 (for now)
      dotnetCorePackages.sdk_9_0-bin

      python313Packages.jupyterlab
      python313Packages.jupyter-core
      python313Packages.ipython
      python314

      # Software
      geekbench
      discord # probably will have to wrap
      # megacmd # ts dont fucking work
      megasync
      vscodium
      brave
      obsidian
      zapzap
      prismlauncher
      steam
      protonup-qt

      kdePackages.ark
      kdePackages.kcalc

      # Theming
      nerd-fonts.jetbrains-mono
      kdePackages.breeze
        
      # Shell
      eza
    ];

    sessionVariables = {
      DB_MAIN_BIN = "/usr/local/db-main/bin";
      LD_LIBRARY_PATH = "$DB_MAIN_BIN:$DB_MAIN_BIN/../java/jre/lib/amd64/server:$LD_LIBRARY_PATH";
    };

    sessionPath  = [
      "/usr/local/db-main/bin"
    ];
  };

  # pkg argument; returns boolean wether pkg is allowed or not
  nixpkgs = {
    config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "megasync"
      "geekbench"
      "discord"
      "megacmd"
      "obsidian"
      "steam"
      "steam-unwrapped"
    ];
  };
}
