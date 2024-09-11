require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },

	extensions = {
    	fzf = {
      	fuzzy = true,                    -- false will only do exact matching
      	override_generic_sorter = true,  -- override the generic sorter
      	override_file_sorter = true,     -- override the file sorter
      	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    	}
  	}
})

require('telescope').load_extension('fzf')

--Telescopic keybinds
local builtin = require('telescope.builtin')
local keys = vim.keymap.set
keys('n', '<leader>ff', builtin.find_files, {})
keys('n', '<leader>fg', builtin.live_grep, {})
keys('n', '<leader>fb', builtin.buffers, {})
keys('n', '<leader>fh', builtin.help_tags, {})

--Search within a git repo
keys('n', '<C-p>', builtin.git_files, {})
