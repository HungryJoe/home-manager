{ config, pkgs, language-servers, ... }:

with pkgs;

{
home = {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  username = "skagan";
  homeDirectory = "/Users/skagan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    bash
    bash-completion
    bat
    bottom
    delta
    direnv
    nix-direnv
    du-dust
    eza
    fd
    fish
    fzf
    ghostscript
    git
    gitui
    gnupg
    gnutls
    go
    graphviz
    helix
    imagemagick
    jq
    lazygit
    lua
    lua-language-server
    luarocks
    mysql
    nil
    nmap
    nodejs
    pandoc
    pdftk
    perl
    poppler_utils
    postgresql_14
    pre-commit
    procs
    pv
    python310Full
    ripgrep
    sd
    sqlite
    stylua
    tokei
    tree-sitter
    procps
    zoxide
    gcc
    db
    getopt
    coreutils
    cmakeMinimal
    liquibase
    wget
    poetry
    sqlitebrowser
    ripgrep
    ripgrep-all
    jdk8
    maven
    keepassxc
    nginx

    python310Packages.pip

    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.pyright
    nodePackages."@angular/cli"
    # Nix doesn't currently have @angular/language-server in its package repo,
    #   so it must be installed separately.
    language-servers.angular-language-server
    
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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/skagan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  sessionVariables = {
    # EDITOR = "emacs";
  };
};
programs = {

  # Let Home Manager install and manage itself.
  home-manager.enable = true;

  neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    extraPython3Packages = pyPkgs: [pyPkgs.pynvim];
    extraPackages = [nodePackages.neovim];
  };

  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
};
}
