{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    prefix = "C-a";
    terminal = "xterm-256color";
    extraConfig = ''
      # Menambahkan konfigurasi vim-tmux-navigator secara manual
      # bind -n C-h select-pane -L
      # bind -n C-j select-pane -D
      # bind -n C-k select-pane -U
      # bind -n C-l select-pane -R
      # bind -n C-\\ select-pane -l
      set-option -sa terminal-overrides ",xterm-256color*:Tc" 
      set -g @yank_selection_mouse 'clipboard'
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
      # Membuat pane tetap sinkron dengan Vim saat berpindah antar pane tmux
      # if-shell '[ -n "$TMUX" ]' 'bind -n C-h select-pane -L; bind -n C-j select-pane -D; bind -n C-k select-pane -U; bind -n C-l select-pane -R; bind -n C-\\ select-pane -l'
    '';
  };
}
