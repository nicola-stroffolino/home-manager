{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
   
    shellAliases = {
      ls = "eza -a --icons";
      ll = "eza -al --icons";
      lt = "f() { eza -a --tree --level=$1 --icons }; f";
      apt = "\\nala";
      dapt = "\\apt";
      sudo = "sudo ";
      code = "codium";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];   
    };

    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      fastfetch
    '';
  };

  home.packages = [
    pkgs.zsh-powerlevel10k
  ];
}