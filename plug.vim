" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    plugs.vim                                          :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/02/26 22:46:04 by wszurkow          #+#    #+#              "
"    Updated: 2022/02/26 22:46:05 by wszurkow         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"################################################ "
"### PLUG ###"
"################################################ "
 autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=500}

" Auto install
"""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Wilder init
""""""""""""""
function! UpdateRemotePlugins(...)
	" Needed to refresh runtime files
	let &rtp=&rtp
	UpdateRemotePlugins
endfunction

" PLug call
""""""""""""
call plug#begin('~/.vim/plugged')

" TESTING
"""""""""
"Plug 'sickill/vim-pasta'" break visual multi
Plug 'ggandor/leap.nvim'
Plug 'dosimple/workspace.vim',{'on': 'WS' }
"Plug 'thaerkh/vim-workspace' " This is actually sessions, not workspaces
Plug 'voldikss/vim-floaterm'
Plug 'folke/which-key.nvim'
"Plug 'sunaku/tmux-navigate'
"Plug 'wszki/vim-bw'
"Plug 'jaredgorski/fogbell.vim'
"Plug 'morhetz/gruvbox'
"
"Plug 'tpope/vim-obsession'
"Plug 'dhruvasagar/vim-prosession'
"
"Plug 'rmagatti/auto-session',
"
"
"
"Plug 'jedrzejboczar/possession.nvim'

"Plug 'nvim-telescope/telescope.nvim'
"Plug  'rmagatti/auto-session'
"Plug 'rmagatti/session-lens'

"Plug 'sunjon/shade.nvim' " conflict with undotree highlight

"Plug 'folke/noice.nvim'
"Plug 'MunifTanjim/nui.nvim'
"Plug 'rcarriga/nvim-notify'
"Plug 'hrsh7th/nvim-cmp'

"Plug 'google/vim-maktaba'
"Plug 'google/vim-codefmt'
"Plug 'google/vim-glaive'

"Plug 'sbdchd/neoformat'
Plug 'embear/vim-uncrustify'


" THEMES
"""""""""
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mhinz/vim-startify'

"if executable('node')
	"Plug 'neoclide/coc.nvim', { 'branch' : 'release',
				"\ 'do' : 'CocInstall
				"\ coc-explorer
				"\ coc-diagnostic
				"\ coc-explorer
				"\ coc-clangd
				"\ coc-cmake
				"\ coc-fzf-preview
				"\ coc-sh
				"\ coc-snippets
				"\ coc-emmet
				"\ coc-css
				"\ coc-html
				"\ coc-html-css-support
				"\ coc-svg
				"\ coc-eslint
				"\ coc-tsserver
				"\ coc-json
				"\ coc-docker
				"\ '} " Completion
"endif

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

" CORE
""""""
Plug 'preservim/nerdcommenter'        " Commenter
Plug 'mg979/vim-visual-multi'         " Multi cursor
Plug 'airblade/vim-gitgutter'         " Git signs
Plug 'thirtythreeforty/lessspace.vim' " Trim spaces
Plug 'myusuf3/numbers.vim'            " Relative numbers when needed
Plug 'vim-scripts/restore_view.vim'   " Restore view to last line
Plug 'mbbill/undotree'                " Persistent undo
Plug 'machakann/vim-sandwich'         " {[( surround
Plug 'wellle/context.vim'             " Get context within code
Plug 'MunifTanjim/nui.nvim'           " Nvim UI library
Plug 'nvim-lua/plenary.nvim'          " Nvim additional functions
Plug 'nacro90/numb.nvim'              " Peek at line search
Plug 'karb94/neoscroll.nvim'          " Smooth scrolling
Plug 'dstein64/nvim-scrollview'       " Scrollbar
Plug 'nathom/filetype.nvim'           " Unnsure if useful, reduce startup time
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim',         { 'tag'    : 'v2.*'              }

Plug 'pandark/42header.vim',            { 'on'     : 'FortyTwoHeader'    } " 42 header
Plug 'junegunn/fzf',                    { 'on'     : ['Files', 'Buffers', 'GFiles', 'BCommits', 'Ag', 'History', 'BLines', 'Lines'] } " FZF
Plug 'junegunn/fzf.vim',                { 'on'     : ['Files', 'Buffers', 'GFiles', 'BCommits', 'Ag', 'History', 'BLines', 'Lines'] } " FZF
Plug 'chrisbra/colorizer',              { 'on'     : 'ColorToggle'       } " HEX Color display
Plug 'junegunn/vim-easy-align',         { 'on'     : '<Plug>(EasyAlign)' } " Align
Plug 'mhinz/vim-sayonara',              { 'on'     : 'Sayonara'          } " Quit buffer  or tab
Plug 'dstein64/vim-startuptime',        { 'on'     : 'StartupTime'       } " Check  startup time
"Plug 'akinsho/toggleterm.nvim',         { 'on'     : 'ToggleTerm'        } " Better split terminal
Plug 'nvim-treesitter/nvim-treesitter', { 'do'     : 'TSUpdate'          } " Better syntax  ?
Plug 'sindrets/diffview.nvim',          { 'on'     : 'DiffviewOpen'      } " Diff   view
Plug 'liquidfun/vim-comment-banners',   { 'on'     : 'CommentBanner'     }
Plug 'gelguy/wilder.nvim',              { 'on'     : 'CmdlineEnter'      }

" AUDIO
"""""""""""
Plug 'davidgranstrom/scnvim',     { 'for': 'tidal'},
Plug 'supercollider/scvim',       { 'for': 'tidal'},
Plug 'tidalcycles/vim-tidal',     { 'for': 'tidal'},
Plug 'neovimhaskell/haskell-vim', { 'for': 'tidal'},
"Plug 'simonhicks/foxdot.vim'

" FILETYPE SPECIFIC
""""""""""""""""""""

Plug 'mboughaba/i3config.vim',           { 'for' : 'i3config'          } " for is broken
Plug 'plasticboy/vim-markdown',          { 'for' : 'markdown'          } " for is broken
"Plug 'preservim/vim-lexical',            { 'for' : 'markdown'          } " Spell checker
Plug 'leafgarland/typescript-vim',       { 'for' :  ['jsx','tsx']      } " TypeScript syntax
Plug 'pangloss/vim-javascript',          { 'for' : 'jsx'               } " JavaScript support
Plug 'maxmellon/vim-jsx-pretty',         { 'for' : 'jsx'               } " JS and JSX syntax
Plug 'jparise/vim-graphql',              { 'for' : 'jsx'               } " GraphQL syntax
Plug 'bfrg/vim-cpp-modern',              { 'for' : ['c','cpp', 'hpp']  } " for is broken
Plug 'vim-scripts/a.vim',                { 'for' : ['c', 'cpp', 'hpp'] } " :A to switch to header file
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for' : ['c','cpp', 'hpp']  }
Plug 'liuchengxu/vista.vim',             { 'for' : ['c', 'cpp', 'hpp'], 'on' : 'Vista' }
Plug 'tyru/open-browser.vim',            { 'for' : ['c', 'cpp', 'hpp'] }
Plug 'LnL7/vim-nix'
Plug 'puremourning/vimspector', { 'on': '<Plug>VimspectorToggleBreakpoint' }

"	"for" : ['c', 'cpp', 'hpp'],
" do: 'python3 install_gadget.py --enable-vscode-cpptools'


" DISABLED
"""""""""""
Plug 'stormherz/tablify',                {'on' : 'DISABLED'} " Generate ascii tables
Plug 'xavierchow/vim-sequence-diagram',  {'on' : 'DISABLED'} " Generate diagrams
Plug 'ryanoasis/vim-devicons',           {'on' : 'DISABLED'} " Original devicons
Plug '/mattn/emmet-vim',                 {'on' : 'DISABLED'} " ? Useful? Coc-emmet is available
Plug 'octol/vim-cpp-enhanced-highlight', {'on' : 'DISABLED'} " ?
Plug 'roxma/nvim-yarp',                  {'on' : 'DISABLED'} " ?
Plug 'roxma/vim-hug-neovim-rpc',         {'on' : 'DISABLED'} " ?
Plug 'vimlab/split-term.vim',            {'on' : 'DISABLED'} " Better split terminal
Plug 'axlebedev/footprints',             {'on' : 'DISABLED'}  " highlight last changes / MESSES UP HIGHLIGHT COLORS
Plug 'nvim-neo-tree/neo-tree.nvim',      {'on' : ['DISABLED', 'NeoTreeFocusToggle', 'NeoTreeFloatToggle']}
Plug 'mileszs/ack.vim',                  {'on'     : 'Ack'               } " ACK
" Plug 'liuchengxu/vim-which-key',        { 'on': ['WhichKey', 'WhichKey!'] }
call plug#end()
lua <<EOF
local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()
EOF
"call glaive#Install()
"Glaive codefmt plugin[mappings]
"Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"
"augroup autoformat_settings
  "autocmd FileType bzl AutoFormatBuffer buildifier
  "autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  "autocmd FileType dart AutoFormatBuffer dartfmt
  "autocmd FileType go AutoFormatBuffer gofmt
  "autocmd FileType gn AutoFormatBuffer gn
  "autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  "autocmd FileType java AutoFormatBuffer google-java-format
  "autocmd FileType python AutoFormatBuffer yapf
  """ Alternative: autocmd FileType python AutoFormatBuffer autopep8
  "autocmd FileType rust AutoFormatBuffer rustfmt
  "autocmd FileType vue AutoFormatBuffer prettier
  "autocmd FileType swift AutoFormatBuffer swift-format
"augroup END

