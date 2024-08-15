{ pkgs, ... }:
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
        plugin = gruvbox-nvim;
        type = "lua";
        config = builtins.readFile(./nvim/plugin/gruvbox.lua);
      }

      neodev-nvim

      nvim-cmp
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
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
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
    ];
  };
}
