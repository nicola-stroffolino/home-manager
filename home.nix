{ config, pkgs, nixGL, ... }:

let 
  nixGLwrap = pkg: config.lib.nixGL.wrap pkg;
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  targets.genericLinux = {
    enable = true;
    # nixGL = {
    #   packages = nixGL.packages;
    #   defaultWrapper = "mesa";
    #   installScripts = [ "mesa" ];
    # };

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
      gtk3 # probably not needed
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
      vscodium
      brave
      (nixGLwrap obsidian)
      (nixGLwrap zapzap)
      kdePackages.ark
      (nixGLwrap prismlauncher)
      kdePackages.kcalc
      (nixGLwrap steam)
      protonup-qt

      # Theming
      nerd-fonts.jetbrains-mono
      kdePackages.breeze
        
      # Shell
      zsh
      eza
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/nstroffo/etc/profile.d/hm-session-vars.sh
    sessionVariables = {

    };
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
