{ pkgs, inputs, ... }:

# see flake.nix in main directory
let
  own-terminal-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "toggleterm";
    src = inputs.plugin-terminal;
  };
in 
{

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;


    extraPackages = with pkgs; [
      lua-language-server
      nil
      luajitPackages.lua-lsp
    ];

    # Lua configuration can be sourced like so
    extraLuaConfig = ''
      ${builtins.readFile(./nvim/options.lua)}
      ${builtins.readFile(./nvim/keymap.lua)}
      ${builtins.readFile(./nvim/plugin/other.lua)}
    '';

    # Adding plugins
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-surround;
        type = "lua";
        config = "require(\"nvim-surround\").setup({})";
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile(./nvim/plugin/lsp.lua);
      }

      {
        plugin = comment-nvim;
        type = "lua";
        config = "require(\"Comment\").setup()";
      }

      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = builtins.readFile(./nvim/plugin/catppuccin.lua);
      }

      neodev-nvim

      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile( ./nvim/plugin/cmp.lua);
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile(./nvim/plugin/telescope.lua);
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.c 
          p.nix
          p.lua 
          p.bash
          p.json
          p.jsonc
          p.css
        ]));
        type = "lua";
        config = builtins.readFile(./nvim/plugin/treesitter.lua);
      }

      {
        plugin = nvim-highlight-colors;
        type = "lua";
        config = builtins.readFile(./nvim/plugin/csscolors.lua);
      }

      {
        plugin = lspkind-nvim;
        type = "lua";
        config = builtins.readFile(./nvim/plugin/lspkind.lua);
      }
      vim-nix

      {
        plugin = plenary-nvim;
        type = "lua";
        config = "local async = require \"plenary.async\"";
      }
      
      {
        plugin = own-terminal-nvim;
        type = "lua";
        config = "require(\"toggleterm\").setup()";
      }
    ];
  };
}
