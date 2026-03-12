{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k";
      plugins = [ "git" ];
    };
    history = {
      size = 10000;
      save = 10000;
      share = true;
    };
    initContent = ''
      if [[ -f ~/.p10k.zsh ]]; then
        source ~/.p10k.zsh
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
