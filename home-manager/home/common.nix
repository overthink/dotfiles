{
  config,
  pkgs,
  lib,
  ...
}:

{
  home = {
    username = "mark";
    stateVersion = "25.05";

    packages = with pkgs; [
      coreutils
      curl
      d2
      docker
      duckdb
      entr
      fd
      fswatch
      gawk
      gnumake
      gnupg
      gnused
      htop
      imagemagick
      jq
      moreutils
      mtr
      shellcheck
      tree
      wget
      yq-go

      # nix editing
      nil
      nixfmt-rfc-style
      statix
    ];

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -laF";
    };

    activation.createVimTempDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.local/share/vim/{backup,swap,undo}
    '';

    file = {
      ".ssh/allowed_signers".text = ''
        * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPRxjeY5t5aG4lzGTmjXbsONZ+pnmzHGUfsaMHDbECO mark.feeney@gmail.com
      '';
    };

    file = {
      ".psqlrc".text = ''
        \pset pager off
        \timing on
      '';
    };

    sessionPath = [ "$HOME/bin" ];

    sessionVariables = {
      # EDITOR = "vim";
    };
  };

  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    atuin = {
      enable = true;
      enableBashIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        inline_height = 30;
      };
    };

    readline = {
      enable = true;
      extraConfig = ''
        set editing-mode vi
      '';
    };

    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
        export PS1='\w $(__git_ps1 "(%s) ")$ '
      '';
    };

    ripgrep = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "rg --files --ignore-vcs --hidden";
    };

    git = {
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
        options = {
          navigate = true;
          line-numbers = true;
        };
      };
      ignores = [
        ".netrwhist"
        "*.swp"
      ];
      extraConfig = {
        # Sign all commits using ssh key
        commit.gpgsign = true;
        diff.colorMoved = "default";
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        init.defaultBranch = "main";
        merge.conflictStyle = "diff3";
        push = {
          autoSetupRemote = true;
        };
      };
    };

    tmux = {
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

    vim = {
      packageConfigurable = if pkgs.stdenv.isDarwin then pkgs.vim-darwin else pkgs.vim;
      enable = true;
      defaultEditor = true;

      settings = {
        backupdir = [ "~/.local/share/vim/backup" ];
        undodir = [ "~/.local/share/vim/undo" ];
      };

      plugins = with pkgs.vimPlugins; [
        ale
        fzf-vim
        typescript-vim
        vim-autoformat
        vim-fugitive
        vim-gitgutter
        vim-gnupg
        vim-go
        vim-javascript
        vim-jsx-pretty
        vim-jsx-typescript
        vim-markdown
        vim-unimpaired
      ];

      extraConfig = builtins.readFile ../modules/vim/.vimrc;
    };

    ssh = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
