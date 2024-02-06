{ inputs, outputs, lib, config, pkgs, ... }:
let
  impure = dir: "${config.home.homeDirectory}/.flake/config/${dir}";
  path = dir: config.lib.file.mkOutOfStoreSymlink (impure dir);
in
{
  imports = [
    inputs.neovim.homeManagerModules.nixvim
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ben";
    homeDirectory = "/home/ben";
    packages = with pkgs; [
      vlc
      brave
      steam
      discord
      mission-center
      gnome.nautilus
      gnome.gnome-calculator
      gnome.gnome-disk-utility
      gnome.gnome-system-monitor

      ranger

      htop
      tldr
      todo
      pfetch
      neofetch
      tty-clock
      pipes-rs
      cava

      fd
      ripgrep

      avizo
      eww-wayland
      mako
      mpvpaper
      rofi-wayland
      swayidle
      swaylock-effects

      libnotify
      pamixer
      sox
      wlr-randr
      wl-clipboard
      xdg-utils

      inputs.hyprpaper.packages.${system}.default
    ];
  };

  programs.home-manager.enable = true;

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
    git = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "Coldark-Dark";
    extraPackages = with pkgs.bat-extras; [
      batdiff batman batgrep batwatch
    ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "benvonh";
    userEmail = "benjaminvonsnarski@gmail.com";
    extraConfig.credential.helper = "store";
  };

  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      prompt = "enabled";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      truecolor = true;
      force_tty = false;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    initExtra = "source ${(impure "zsh/setup.zsh")}";
    # initExtra = "source ~/.flake/config/zsh/setup.zsh";
    shellAliases = {
      ga = "git add";
      gd = "git diff";
      gp = "git push";
      gc = "git commit";
      gs = "git status";
      hms = "home-manager switch --flake ~/.flake";
      nrs = "sudo nixos-rebuild switch --flake ~/.flake";
    };
    zplug = {
      enable = true;
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [ as:theme depth:1 ];
        }
        {
          name = "marlonrichert/zsh-autocomplete";
          tags = [ as:plugin depth:1 ];
        }
      ];
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "kitty";
    shortcut = "s";
    extraConfig = ''
      set -g status-position top
    '';
    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = ''
          set -g @tmux_power_left_arrow_icon '''
          set -g @tmux_power_right_arrow_icon '''
        '';
      }
    ];
  };

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

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    globals.mapleader = " ";
    options = {
      allowrevins = true;
      autoindent = true;
      autoread = true;
      autowrite = false;
      autowriteall = false;
      background = "dark";
      backup = false;
      clipboard = "";
      cmdheight = 1;
      colorcolumn = "120";
      confirm = true;
      cursorline = true;
      expandtab = true;
      hlsearch = false;
      incsearch = true;
      number = true;
      pumheight = 8;
      pumwidth = 24;
      scrolloff = 8;
      shiftround = false;
      shiftwidth = 4;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      smarttab = true;
      softtabstop = 4;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      syntax = "yes";
      tabstop = 4;
      termguicolors = true;
      timeout = true;
      timeoutlen = 1000;
      undofile = true;
      undolevels = 1000;
      visualbell = true;
      wrap = false;
    };
    keymaps = [
      { mode = "i"; key = "<c-c>"; action = "<esc>"; }

      { mode = "v"; key = "<"; action = "<gv"; }
      { mode = "v"; key = ">"; action = ">gv"; }
      { mode = "v"; key = "J"; action = ":m '>+1<cr>gv=gv"; }
      { mode = "v"; key = "K"; action = ":m '<-2<cr>gv=gv"; }
      { mode = "v"; key = "p"; action = "\"_dP"; }

      { mode = "n"; key = "n"; action = "nzz"; }
      { mode = "n"; key = "N"; action = "Nzz"; }
      { mode = "n"; key = "<a-h>"; action = "<c-w>H"; }
      { mode = "n"; key = "<a-j>"; action = "<c-w>J"; }
      { mode = "n"; key = "<a-k>"; action = "<c-w>K"; }
      { mode = "n"; key = "<a-l>"; action = "<c-w>L"; }
      { mode = "n"; key = "<c-u>"; action = "<c-u>zz"; }
      { mode = "n"; key = "<c-d>"; action = "<c-d>zz"; }
      { mode = "n"; key = "H"; action = "<cmd>bprev<cr>"; }
      { mode = "n"; key = "L"; action = "<cmd>bnext<cr>"; }

      { mode = "" ; key = "<leader>y"; action = "\"+y"; }
      { mode = "" ; key = "<leader>Y"; action = "\"+Y"; }
      { mode = "" ; key = "<leader>d"; action = "\"_d"; }
      { mode = "" ; key = "<leader>D"; action = "\"_D"; }

      { mode = "n"; key = "<leader>q"; action = "<cmd>q<cr>"; }
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<cr>"; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>x<cr>"; }
      { mode = "n"; key = "<leader>a"; action = "<cmd>qa<cr>"; }
      { mode = "n"; key = "<leader>s"; action = "<cmd>wa<cr>"; }
      { mode = "n"; key = "<leader>z"; action = "<cmd>xa<cr>"; }
      { mode = "n"; key = "<leader>v"; action = "<cmd>vsplit<cr>"; }
      { mode = "n"; key = "<leader>r"; action = "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>"; }

      { mode = "n"; key = "<leader>e"; action = "<cmd>NvimTreeToggle<cr>"; }
      { mode = "n"; key = "<leader>l"; action = "<cmd>Telescope live_grep<cr>"; }
      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<cr>"; }
    ];
    autoCmd = [
      {
        event = "FileType";
        pattern = [ "*.c" "*.cpp" "*.nix" ];
        command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
      }
    ];
    plugins = {
      which-key = {
        enable = true;
        registrations = {
          "<leader>r" = "Remove buffer";
          "<leader>q" = "Quit buffer";
          "<leader>w" = "Write buffer";
          "<leader>x" = "Quit+Write buffer";
          "<leader>a" = "Abandon buffers";
          "<leader>s" = "Save all buffers";
          "<leader>z" = "Save and quit";
          "<leader>v" = "Split vertical";
          "<leader>e" = "Toggle file explorer";
          "<leader>l" = "Live grep";
          "<leader>f" = "Find file";
        };
      };

      telescope.enable = true;
      comment-nvim.enable = true;
      cursorline.enable = true;

      lualine = {
        enable = true;
        globalstatus = true;
        sectionSeparators.left = "";
        sectionSeparators.right = "";
        componentSeparators.left = "";
        componentSeparators.right = "";
      };

      bufferline = {
        enable = true;
        diagnostics = "nvim_lsp";
      };

      nvim-tree = {
        enable = true;
        git.ignore = false;
        hijackCursor = true;
        diagnostics.enable = true;
        diagnostics.showOnDirs = true;
        updateFocusedFile.enable = true;
        renderer.indentMarkers.enable = true;
        renderer.icons.gitPlacement = "after";
      };

      indent-blankline = {
        enable = true;
        scope.showStart = false;
        scope.showEnd = false;
        indent.char = "▏";
      };

      treesitter = {
        enable = true;
        indent = true;
      };

      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          cmake.enable = true;
          cssls.enable = true;
          # FIXME: Not available in 23.11
          # dockerls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          # FIXME: Not available in 23.11
          # marksman.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          rust-analyzer.enable = true;
          rust-analyzer.installCargo = true;
          rust-analyzer.installRustc = true;
          texlab.enable = true;
          yamlls.enable = true;
        };
      };

      lspkind = {
        enable = true;
        cmp.enable = true;
        mode = "symbol_text";
      };

      luasnip.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;

      nvim-cmp = {
        enable = true;
        preselect = "Item";
        snippet.expand = "luasnip";
        mappingPresets = [ "insert" "cmdline" ];
        mapping = {
          "<c-e>" = "cmp.mapping.abort()";
          "<c-u>" = "cmp.mapping.scroll_docs(4)";
          "<c-d>" = "cmp.mapping.scroll_docs(-4)";
          "<c-n>" = "cmp.mapping.select_next_item()";
          "<c-p>" = "cmp.mapping.select_prev_item()";
          "<tab>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };

      nvim-autopairs = {
        enable = true;
        enableAbbr = true;
        checkTs = true;
        mapCW = true;
      };

      markdown-preview = {
        enable = true;
        autoStart = true;
      };

      noice = {
        enable = true;
      };

      rainbow-delimiters = {
        enable = true;
      };

      todo-comments.enable = true;

      trouble.enable = true;

      tmux-navigator = {
        enable = true;
        tmuxNavigatorSaveOnSwitch = 2;
      };
    };
  };

  xdg.configFile = {
    avizo.source = path "avizo";
    eww.source = path "eww";
    hypr.source = path "hypr";
    mako.source = path "mako";
    rofi.source = path "rofi";
    swayidle.source = path "swayidle";
    swaylock.source = path "swaylock";
    wofi.source = path "wofi";
  };

  gtk = with pkgs; {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-BL";
      package = gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Numix-Circle";
      package = numix-icon-theme-circle;
    };
    cursorTheme = {
      size = 24;
      name = "dist-white";
      package = vimix-cursors;
    };
    font = {
      size = 10;
      name = "CaskaydiaCove Nerd Font";
      package = (nerdfonts.override {
        fonts = [ "CascadiaCode" ];
      });
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
