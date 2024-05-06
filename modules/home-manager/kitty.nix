{ ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
    settings = {
      shell = "zsh";
      cursor_shape = "block";
      shell_integration = "no-cursor";
      placement_strategy = "center";
    };
    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 11;
    };
    shellIntegration = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };

}
