-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   plug_settings.lua                                  :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: wsz </var/spool/mail/wsz>                  +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2022/02/26 22:26:26 by wsz               #+#    #+#             --
--   Updated: 2022/02/26 22:26:30 by wsz              ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --



-- =============================================================================
-- -------------------------------- POSSESSION ---------------------------------
-- =============================================================================

--require('possession').setup {
    ----session_dir = (Path:new(vim.fn.stdpath('data')) / 'possession'):absolute(),
    --silent = false,
    --load_silent = true,
    --debug = false,
    --prompt_no_cr = false,
    --autosave = {
        --current = false,  -- or fun(name): boolean
        --tmp = false,  -- or fun(): boolean
        --tmp_name = 'tmp',
        --on_load = true,
        --on_quit = true,
    --},
    --commands = {
        --save = 'PossessionSave',
        --load = 'PossessionLoad',
        --close = 'PossessionClose',
        --delete = 'PossessionDelete',
        --show = 'PossessionShow',
        --list = 'PossessionList',
        --migrate = 'PossessionMigrate',
    --},
    --hooks = {
        --before_save = function(name) return {} end,
        --after_save = function(name, user_data, aborted) end,
        --before_load = function(name, user_data) return user_data end,
        --after_load = function(name, user_data) end,
    --},
    --plugins = {
        --close_windows = {
            --hooks = {'before_save', 'before_load'},
            --preserve_layout = true,  -- or fun(win): boolean
            --match = {
                --floating = true,
                --buftype = {},
                --filetype = {},
                --custom = false,  -- or fun(win): boolean
            --},
        --},
        --delete_hidden_buffers = {
            --hooks = {
                --'before_load',
                --vim.o.sessionoptions:match('buffer') and 'before_save',
            --},
            --force = false,  -- or fun(buf): boolean
        --},
        --nvim_tree = true,
        --tabby = true,
        --delete_buffers = false,
    --},
--}

-- =============================================================================
-- ------------------------------- AUTO SESSION --------------------------------
-- =============================================================================


--local opts = {
	--log_level = 'info',
	--auto_session_enable_last_session = false,
	--auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
	--auto_session_enabled = true,
	--auto_save_enabled = true,
	--auto_restore_enabled = true,
	--auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
	--auto_session_use_git_branch = nil,
	---- the configs below are lua only
	--bypass_session_save_file_types = nil
--}

--require('auto-session').setup(opts)

--vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
--require("auto-session").setup {
--log_level = "error",
--}
--require('session-lens').setup({[>your custom config--<]})

-- =============================================================================
-- ----------------------------------- SHADE -----------------------------------
-- =============================================================================
--
-- CONFLICTS WITH UNDOTREE

--require'shade'.setup({
--overlay_opacity = 85,
--opacity_step = 1,
--keys = {
----brightness_up    = '<C-n>',
----brightness_down  = '<C-m>',
----toggle           = '<Leader>s',
--}
--})

-- =============================================================================
-- ----------------------------------- NOICE -----------------------------------
-- =============================================================================

--require("notify").setup({
--render = "minimal",
--stages = "static"
--})

--require("noice").setup {
--win_options = {
--winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
--},
--cmdline = {
--view =  "notify", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
--opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
--icons = {
--},
--icons = {
--["/"] = { icon = "  ", hl_group = "Normal" },
--["?"] = { icon = "  ", hl_group = "Normal" },
--[":"] = { icon = "  ", hl_group = "Normal", firstc = false },
--},
--},
--popupmenu = {
--enabled = true, -- disable if you use something like cmp-cmdline
-----@type 'nui'|'cmp'
--backend = "nui", -- backend to use to show regular cmdline completions
---- You can specify options for nui under `config.views.popupmenu`
--},
--history = {
---- options for the message history that you get with `:Noice`
--view = "split",
--opts = { enter = true },
--filter = { event = "msg_show", ["not"] = { kind = { "FUZZY", "search_count", "echo" } } },
--},
--throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
-----@type table<string, NoiceViewOptions>
--views = {}, -- @see the section on views below
-----@type NoiceRouteConfig[]
--routes = {}, -- @see the section on routes below
-----@type table<string, NoiceFilter>
--status = {}, --@see the section on statusline components below
--}

-- =============================================================================
-- --------------------------------- WHICH KEY ---------------------------------
-- =============================================================================

vim.cmd([[
set timeoutlen=50
autocmd FileType WhichKey highlight WhichKeyFloat guibg=#2A2E31 ctermbg=black ctermfg=white
autocmd BufEnter * ContextEnable
autocmd BufLeave * ContextDisable
]])

require("which-key").setup
{
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	popup_mappings = {
		scroll_down = '<c-d>', -- binding to scroll down inside the popup
		scroll_up = '<c-u>', -- binding to scroll up inside the popup
	},
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k", "\\" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
}

-- =============================================================================
-- ----------------------------------- LEAP ------------------------------------
-- =============================================================================
--
require('leap').set_default_keymaps()

-- =============================================================================
-- ---------------------------------- LUALINE ----------------------------------
-- =============================================================================

require('lualine').setup{
	options = {
		icons_enabled = false,
	},
	refresh = {                  -- sets how often lualine should refreash it's contents (in ms)
	statusline = 10000, -- The refresh option sets minimum time that lualine tries
	tabline    = 10000, -- to maintain between refresh. It's not guarantied if situation
	winbar     = 10000  -- arises that lualine needs to refresh itself before this time
	-- it'll do it.

	-- Also you can force lualine's refresh by calling refresh function
	-- like require('lualine').refresh()
},
sections = {
	lualine_e = {
		{
			'diagnostics',

			-- Table of diagnostic sources, available sources are:
			--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
			-- or a function that returns a table as such:
			--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
			sources = { 'coc' },

			-- Displays diagnostics for the defined severity types
			sections = { 'error', 'warn', 'info', 'hint' },

			diagnostics_color = {
				-- Same values as the general color option can be used here.
				error = 'DiagnosticError', -- Changes diagnostics' error color.
				warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
				info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
				hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
			},
			symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
			colored = true,           -- Displays diagnostics status in color if set to true.
			update_in_insert = false, -- Update diagnostics in insert mode.
			always_visible = false,   -- Show diagnostics even if there are none.
		}
	},
	lualine_f = {
		{
			'diff',
			colored = true, -- Displays a colored diff status if set to true
			diff_color = {
				-- Same color values as the general color option can be used here.
				added    = 'DiffAdd',    -- Changes the diff's added color
				modified = 'DiffChange', -- Changes the diff's modified color
				removed  = 'DiffDelete', -- Changes the diff's removed color you
			},
			symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
			source = nil, -- A function that works as a data source for diff.
			-- It must return a table as such:
			--   { added = add_count, modified = modified_count, removed = removed_count }
			-- or nil on failure. count <= 0 won't be displayed.
		}
	},
	--lualine_c = {require('auto-session-library').current_session_name}
}
}


-- =============================================================================
-- ---------------------------------- SCNVIM -----------------------------------
-- =============================================================================

require('scnvim').setup()
local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
	keymaps = {
		['<M-e>'] = map('editor.send_line', {'i', 'n'}),
		['<C-e>'] = {
			map('editor.send_block', {'i', 'n'}),
			map('editor.send_selection', 'x'),
		},
		['<CR>'] = map('postwin.toggle'),
		['<M-CR>'] = map('postwin.toggle', 'i'),
		['<M-L>'] = map('postwin.clear', {'n', 'i'}),
		['<C-k>'] = map('signature.show', {'n', 'i'}),
		['<F12>'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
		['<leader>st'] = map('sclang.start'),
		['<leader>sk'] = map('sclang.recompile'),
		['<F1>'] = map_expr('s.boot'),
		['<F2>'] = map_expr('s.meter'),
	},
	editor = {
		highlight = {
			color = 'IncSearch',
		},
	},
	postwin = {
		float = {
			enabled = true,
		},
	},
}


-- #########################
-- ### FILETYPE.NVIM
-- ##########################

vim.g.did_load_filetypes = 1


-- ##########################
-- ### NUMB
-- ##########################

require('numb').setup()

-- ##########################
-- ### TOGGLETERM
-- ##########################

--require("toggleterm").setup{
--open_mapping = [[<c-\>]],
----on_open = fun(t: Terminal), -- function to run when the terminal opens
----on_close = fun(t: Terminal), -- function to run when the terminal closes
----on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
----on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
----on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
--direction = 'horizontal',--direction = 'vertical' | 'horizontal' | 'tab' | 'float',
--hide_numbers = false,
--shade_terminals = true,
--shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
--float_opts = {
---- The border key is *almost* the same as 'nvim_open_win'
---- see :h nvim_open_win for details on borders however
---- the 'curved' border is a custom border type
---- not natively supported but implemented in this plugin.
--border = 'shadow',
----width = 30,
----height = 30,
--winblend = 20,
--highlights = {
----border = "Normal",
----background = "Normal",
--}
--}
--}
--function _G.set_terminal_keymaps()
--local opts = {noremap = true}
--vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
--vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
--end

---- if you only want these mappings for toggle term use term://*toggleterm#* instead
--vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')


-- ##########################
-- ### BUFFERLINE
-- ##########################

require'bufferline'.setup{
	highlights = {
		fill = {
			fg = '#fabd2f',
			bg = '#1f2428',
		},
		background = {
			fg = '#504945',
			bg = '#191d20'
		},
		modified = {
			bg = '#191d20'
		},
	},
	options = {
		diagnostics             = "coc",
		--numbers = "buffer_id",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		show_buffer_icons       = true,
		show_close_icon         = false,
		show_buffer_close_icons = false,
		show_tab_indicators     = false,
		separator_style         = {"",""},
		indicator = {
			icon = '', -- this should be omitted if indicator style is not 'icon'
			style = 'icon',
		},
		buffer_close_icon       = '',
		modified_icon           = '●',
		close_icon              = '',
		left_trunc_marker       = '',
		right_trunc_marker      = '',

		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and "  " or "  "
			return " " .. count .. icon
		end,
		offsets = {
			{
				--filetype   = "neo-tree",
				filetype   = "coc-explorer",
				text       = " [     ]",
				text_align = "left"
			}
		}
	}
}

-- ##########################
-- ### NEO SCROLL
-- ##########################

vim.cmd([[
inoremap <PageUp> <ESC><PageUp>i
inoremap <PageDown> <ESC><PageDown>i
]])

require('neoscroll').setup({
	-- All these keys will be mapped to their corresponding default scrolling animation
	--mappings             = {'<C-u>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
	mappings             = {'zt', 'zz', 'zb'},
	hide_cursor          = true,  -- Hide cursor while scrolling
	stop_eof             = true,  -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff  = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff    = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true,  -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function      = nil,   -- Default easing function
	pre_hook             = nil,   -- Function to run before the scrolling animation starts
	post_hook            = nil,   -- Function to run after the scrolling animation ends
	performance_mode     = false, -- Disable "Performance Mode" on all buffers.
})
local t = {} -- Syntax: t[keys] = {function, {function arguments}}
t['<PageUp>'] = {'scroll', {'-vim.wo.scroll', 'true', '100', [['sine']]}}
t['<PageDown>'] = {'scroll', { 'vim.wo.scroll', 'true', '100', [['sine']]}}
t['zt']    = {'zt', {'250'}}
t['zz']    = {'zz', {'250'}}
t['zb']    = {'zb', {'250'}}
--t['<PageUp>'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}}
--t['<PageDown>'] = {'scroll', { 'vim.wo.scroll', 'true', '100'}}
--t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
--t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
--t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
--t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
require('neoscroll.config').set_mappings(t)

-- ##########################
-- ### DISABLING UNUSED NVIM PLUGINS
-- ##########################

local disabled_built_ins = {
	--"netrw",
	--"netrwPlugin",
	--"netrwSettings",
	--"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
	--"netrw"
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

