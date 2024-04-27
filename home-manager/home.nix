{ config, pkgs, ... }:

{
  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    age
    coreutils
    curl
    docker
    fzf
    gawk
    git
    gnupg
    gnused
    htop
    jq
    ripgrep
    shellcheck
    openssh
    sops
    tmux
    tree
    vim
    wget
    yq-go
    go
    python3
  ];

  home.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -laF";
  };

  programs.readline = {
    enable = true;
    extraConfig = ''
      set editing-mode vi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "rg --files --ignore-vcs --hidden";
  };

  programs.git = {
    enable = true;
    userName = "overthink";
    userEmail = "mark.feeney@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      st = "status";
      ff = "!git merge --ff-only";
    };
    delta = {
      enable = true;
    };
    ignores = [
      ".netrwhist"
      "*.swp"
    ];
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    customPaneNavigationAndResize = true;
    terminal = "screen-256color";
    extraConfig = ''
      # Change status bar
      set -g status-bg colour234
      set -g status-fg white
      # highlight active window
      set-window-option -g window-status-current-style bg=red
      # put stuff on right
      set -g status-right '#[fg=colour11]#(uptime | cut -d "," -f 3- | sed -e "s/  load average: //")'
    '';
  };

  home.file = {
    ".ssh/allowed_signers".text = ''
      * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPRxjeY5t5aG4lzGTmjXbsONZ+pnmzHGUfsaMHDbECO mark.feeney@gmail.com
    '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
