{ config, pkgs, ... }:

{
  home =  {
    username = "luke";
    homeDirectory = "/home/luke";
    # Do not change.
    stateVersion = "24.11";
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello
  
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  
      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      alacritty
      bazelisk
      bitwarden-desktop
      discord
      element-desktop
      ffmpeg
      fzf
      gh
      ghc
      gifski
      git
      google-chrome
      htop
      neovim
      nixfmt-rfc-style
      ripgrep
      starship
      sqlite
      telegram-desktop
      tmux
      tree
      unzip
      virtualbox
      wget
      zip
      zsh
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
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
    # 'home.sessionVariables'. These will be explicitly sourced when using a
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
    #  /etc/profiles/per-user/luke/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      g = "git";
      v = "nvim";
      h = "htop";
      t = "tree";
    };
  };

  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    firefox.enable = true;

    git = {
      enable = true;
      extraConfig = {
        user.name = "Luke Peterson";
        user.email = "hazelnusse@gmail.com";
        init.defaultBranch = "main";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      defaultKeymap = "viins";
    };
  };
}
