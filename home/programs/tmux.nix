{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    prefix = "C-a";
    terminal = "xterm-256color";
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-256color*:Tc" 
      set -g @yank_selection_mouse 'clipboard'
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
    '';
  };
}
