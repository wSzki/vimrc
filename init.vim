" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    init.vim                                           :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/11/12 02:38:53 by wszurkow          #+#    #+#              "
"    Updated: 2022/11/12 03:47:11 by wszurkow         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

set runtimepath^=~/.vim
"set runtimepath+=~/.vim/after

" ==============================================================================
" ------------------------------------ CORE ------------------------------------
" ==============================================================================

" Highlight yanked region
" """""""""""""""""""""""
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=500}

" Auto install
"""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" True Color settings
""""""""""""""""""""""
if has('termguicolors')
	set termguicolors
endif

" Wilder init
""""""""""""""
function! UpdateRemotePlugins(...)
	" Needed to refresh runtime files
	let &rtp=&rtp
	UpdateRemotePlugins
endfunction
" ==============================================================================
" ---------------------------------- SETTERS -----------------------------------
" ==============================================================================

" .........................................................
" ....................... Settings ........................
" .........................................................
set cmdheight=0 " hide commandline when unused
set clipboard^=unnamed,unnamedplus
set scrolloff=5
set noswapfile
set foldmethod=syntax
set nocompatible
set splitright
set foldnestmax=1
set foldlevelstart=20
"set laststatus=2
""set autochdir

" .........................................................
" ................ Lines, rulers, wrapping ................
" .........................................................
set nowrap
set cursorcolumn
set cursorline
"set linebreak
"set ruler
"set tabstop=4
"set shiftwidth=4
"set breakindent
"set breakindentopt=shift:2
"set showbreak=↳
"set cc=80

" .........................................................
" ......................... Split .........................
" .........................................................
"Automatically equalize splits when Vim is resized
"autocmd VimResized * wincmd =
"set splitbelow
"set splitright

" WhiteSpaces
""""""""""""""
set list
set listchars=space:.,tab:•-,trail:~,extends:>,precedes:<

" .........................................................
" .. Improve scroll performance for certain file types: ...
" .........................................................
augroup syntaxSyncMinLines
	autocmd!
	autocmd Syntax * syntax sync minlines=2000
augroup END

" .........................................................
" ................... Performance misc ....................
" .........................................................
set encoding=utf-8
set complete-=5
set lazyredraw
set re=1
"set redrawtime=100
"set timeoutlen=1000 " slows down whichkey
set synmaxcol=400
syntax sync minlines=256

" ==============================================================================
" ------------------------------------ MAPS ------------------------------------
" ==============================================================================

" ..........................................................
" .......................... MISC ..........................
" ..........................................................
nnoremap ; :
vnoremap ; :
nnoremap <CR>  :match<CR>:noh<CR>
noremap gg gg=G``zz :execute 'match Search /\%'.line('.').'l/'<CR>

" ..........................................................
" ................... PLUGINS SHORTCUTS ....................
" ..........................................................
nnoremap <leader>vi :Vista<CR>

noremap <leader>c1 :CommentBanner --pattern =,1-,=  --width 80 --comment true<CR>
noremap <leader>c2 :CommentBanner --pattern .,1.,.  --width 60 --comment true<CR>

nnoremap <leader>co :ColorizerToggle<CR>

nnoremap <C-p> :NeoTreeFocusToggle<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ..........................................................
" ........................ DISABLE .........................
" ..........................................................
nnoremap <F1> <nop>
inoremap <F1> <nop>

" ..........................................................
" ..................... SMOOTH SCROLL ......................
" ..........................................................
imap <PageUp>   <ESC><PageUp>i
imap <PageDown> <ESC><PageDown>i<Right>

" ..........................................................
" ....................... SAVE, EXIT .......................
" ..........................................................
nnoremap <C-s> <ESC><ESC><ESC>:w<CR><ESC>
inoremap <C-s> <ESC><ESC><ESC>:w<CR><ESC>i
nnoremap <C-q> <ESC><ESC>:Sayonara<CR>
inoremap <C-q> <ESC><ESC>:Sayonora<CR>

" ..........................................................
" ....................... NAVIGATION .......................
" ..........................................................
nnoremap <C-PageUp>        :bp<CR>
nnoremap <C-PageDown>      :bn<CR>
inoremap <C-PageUp>        <ESC><ESC>:bp<CR>
inoremap <C-PageDown>      <ESC><ESC>:bn<CR>
nnoremap <silent><C-Right> <c-w>l
nnoremap <silent><C-Left>  <c-w>h
nnoremap <silent><C-Up>    <c-w>k
nnoremap <silent><C-Down>  <c-w>j

" ==============================================================================
" ---------------------------------- PLUGINS -----------------------------------
" ==============================================================================
"
call plug#begin('~/.vim/plugged')

" ..........................................................
" ........................ TESTING .........................
" ..........................................................
Plug 'ggandor/leap.nvim'
"Plug 'dosimple/workspace.vim',{'on': 'WS' }
"Plug 'voldikss/vim-floaterm'
Plug 'folke/which-key.nvim'
Plug 'embear/vim-uncrustify'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
"Plug 'nvim-neo-tree/neo-tree.nvim',  {'on' : ['NeoTreeFocusToggle', 'NeoTreeFloatToggle']}
Plug 'nvim-neo-tree/neo-tree.nvim'

" ..........................................................
" ......................... THEMES .........................
" ..........................................................
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
Plug 'nvim-lualine/lualine.nvim'

" ..........................................................
" .......................... LSP ...........................
" ..........................................................
" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'           ,{'on' : 'Mason'}
Plug 'williamboman/mason-lspconfig.nvim' ,{'on' : 'Mason'}

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'saadparwaiz1/cmp_luasnip'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

" ..........................................................
" ......................... UTILS ..........................
" ..........................................................
Plug 'mhinz/vim-startify'             " Startpage + session manager
Plug 'preservim/nerdcommenter'        " Commenter
Plug 'mg979/vim-visual-multi'         " Multi cursor
Plug 'airblade/vim-gitgutter'         " Git signs
Plug 'thirtythreeforty/lessspace.vim' " Trim spaces
Plug 'myusuf3/numbers.vim'            " Relative numbers when needed
Plug 'vim-scripts/restore_view.vim'   " Restore view to last line
Plug 'mbbill/undotree'                " Persistent undo
Plug 'machakann/vim-sandwich'         " {[( surround
Plug 'MunifTanjim/nui.nvim'           " Nvim UI library
Plug 'nvim-lua/plenary.nvim'          " Nvim additional functions
Plug 'nacro90/numb.nvim'              " Peek at line search
Plug 'karb94/neoscroll.nvim'          " Smooth scrolling
Plug 'dstein64/nvim-scrollview'       " Scrollbar
Plug 'nathom/filetype.nvim'           " Unnsure if useful, reduce startup time
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim',         { 'tag'    : 'v2.*'              }
"Plug 'wellle/context.vim'             " Get context within code

" ..........................................................
" .......................... LAZY ..........................
" ..........................................................
Plug 'pandark/42header.vim',            { 'on'     : 'FortyTwoHeader'    } " 42 header
Plug 'junegunn/fzf',                    { 'on'     : ['Files', 'Buffers', 'GFiles', 'BCommits', 'Ag', 'History', 'BLines', 'Lines'] } " FZF
Plug 'junegunn/fzf.vim',                { 'on'     : ['Files', 'Buffers', 'GFiles', 'BCommits', 'Ag', 'History', 'BLines', 'Lines'] } " FZF
Plug 'norcalli/nvim-colorizer.lua' ,              { 'on'     : 'ColorizerToggle'       } " HEX Color display
Plug 'junegunn/vim-easy-align',         { 'on'     : '<Plug>(EasyAlign)' } " Align
Plug 'mhinz/vim-sayonara',              { 'on'     : 'Sayonara'          } " Quit buffer  or tab
Plug 'dstein64/vim-startuptime',        { 'on'     : 'StartupTime'       } " Check  startup time
"Plug 'akinsho/toggleterm.nvim',         { 'on'     : 'ToggleTerm'        } " Better split terminal
Plug 'nvim-treesitter/nvim-treesitter', { 'do'     : 'TSUpdate'          } " Better syntax  ?
Plug 'sindrets/diffview.nvim',          { 'on'     : 'DiffviewOpen'      } " Diff   view
Plug 'liquidfun/vim-comment-banners',   { 'on'     : 'CommentBanner'     }
Plug 'gelguy/wilder.nvim',              { 'on'     : 'CmdlineEnter'      }

" .........................................................
" ......................... AUDIO .........................
" .........................................................
Plug 'davidgranstrom/scnvim',     { 'for': 'tidal'},
Plug 'supercollider/scvim',       { 'for': 'tidal'},
Plug 'tidalcycles/vim-tidal',     { 'for': 'tidal'},
Plug 'neovimhaskell/haskell-vim', { 'for': 'tidal'},
"Plug 'simonhicks/foxdot.vim'

" ..........................................................
" ................... FILETYPE SPECIFIC ....................
" ..........................................................
Plug 'mboughaba/i3config.vim',           { 'for' : 'i3config'          } " for is broken
Plug 'plasticboy/vim-markdown',          { 'for' : 'markdown'          } " for is broken
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

call plug#end()


" ==============================================================================
" ------------------------------- PLUG SETTINGS --------------------------------
" ==============================================================================

" ..........................................................
" ......................  WHICH KEY ........................
" ..........................................................
lua require("which-key").setup{}
set timeoutlen=50
autocmd FileType WhichKey highlight WhichKeyFloat guibg=#2A2E31 ctermbg=black ctermfg=white

" ..........................................................
" ........................ UNDOTREE ........................
" ..........................................................
nnoremap <C-u> :UndotreeToggle<cr>
let g:undotree_WindowLayout         = 2
let g:undotree_ShortIndicators      = 1
let g:undotree_SetFocusWhenToggle   = 1
let g:undotree_HighlightChangedText = 1
let g:undotree_HelpLine             = 1
if has("persistent_undo")
	try
		set undodir=~/.undodir
		set undofile
	catch
	endtry
endif


" ..........................................................
" ........................ STARTIFY ........................
" ..........................................................
let g:startify_custom_header = [
			\ '                                ',
			\ '            __                  ',
			\ '    __  __ /\_\    ___ ___      ',
			\ '   /\ \/\ \\/\ \ /'' __` __`\   ',
			\ '   \ \ \_/ |\ \ \/\ \/\ \/\ \   ',
			\ '    \ \___/  \ \_\ \_\ \_\ \_\  ',
			\ '     \/__/    \/_/\/_/\/_/\/_/  ',
			\ ]

let g:startify_session_before_save = [
			\ "ContextDisable"
			\ ]

nnoremap <leader>ss :SSave!<CR>
nnoremap <leader>sd :SDelete!<CR>
"let g:startify_session_persistence = 1
"let g:startify_session_autoload = 1

" ..........................................................
" ....................... VIMSPECTOR .......................
" ..........................................................
command! -nargs=+ Vfb call vimspector#AddFunctionBreakpoint(<f-args>)
nnoremap <localleader>gd :call vimspector#Launch()<cr>
nnoremap <localleader>gc :call vimspector#Continue()<cr>
nnoremap <localleader>gs :call vimspector#Stop()<cr>
nnoremap <localleader>gR :call vimspector#Restart()<cr>
nnoremap <localleader>gp :call vimspector#Pause()<cr>
nnoremap <localleader>gb <Plug>VimspectorToggleBreakpoint
nnoremap <localleader>gB :call vimspector#ToggleConditionalBreakpoint()<cr>
nnoremap <localleader>gn :call vimspector#StepOver()<cr>
nnoremap <localleader>gi :call vimspector#StepInto()<cr>
nnoremap <localleader>go :call vimspector#StepOut()<cr>
nnoremap <localleader>gr :call vimspector#RunToCursor()<cr>

" ..........................................................
" ......................... EMMET ..........................
" ..........................................................
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
			\  'javascript.jsx' : {
			\      'extends' : 'jsx',
			\  },
			\}

" ..........................................................
" ......................... WILDER .........................
" ..........................................................
" :UpdateRemotePlugins to fix
call wilder#setup({'modes': [':', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({
			\ 'highlighter': wilder#basic_highlighter(),
			\ 'highlights': {
			\   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#fabd2f'}]),
			\ },
			\ 'left': [
			\   ' ', wilder#popupmenu_devicons(),
			\ ],
			\ }))

" ..........................................................
" ....................... 42 HEADER ........................
" ..........................................................
nmap <F12> :FortyTwoHeader<CR>
let b:fortytwoheader_user="wszurkow"
let b:fortytwoheader_mail="wszurkow@student.42.fr"

" ..........................................................
" ...................... VISUAL MULTI ......................
" ..........................................................
let g:VM_maps = {}
let g:VM_maps["Select All"]                  = '\\a'
let g:VM_maps["Add Cursor Down"]             = '<S-Down>'
let g:VM_maps["Add Cursor Up"]               = '<S-Up>'
let g:VM_maps["Add Cursor At Pos"]           = '\\\'
let g:VM_maps['Find Under']                  = '<C-n>'

" ..........................................................
" ....................... EASY ALIGN .......................
" ..........................................................
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map g=  gaip*=
map g\| gaip*\|
map g.  gaip*.
map g,  gaip*,
map g<Space> gaip*<Space>

" ==============================================================================
" ----------------------------------- SYNTAX -----------------------------------
" ==============================================================================

syntax on
syn match cType "\<[a-zA-Z_][a-zA-Z0-9_]*_[t]\>"
syn match cType "\<[t]_*[a-zA-Z_][a-zA-Z0-9_]\>"

syn match cType "\<[a-zA-Z_][a-zA-Z0-9_]*_[t]\>"
syn match cType "*[t]_*[a-zA-Z_][a-zA-Z0-9_]\>"
syn match cType   "\vstruct\s+[a-zA-Z0-9_]+"
"syn match cUserSpecialCharacter display "[~!%^&*()-+=[\]{},.<>?:;]"
syn match cUserSpecialCharacter display "\<*->"
"syn match cUserSpecialCharacter display "[a-zA-Z0-9_]*\*[*]"
syn match cUserSpecialCharacter display "*"
"syn match cUserSpecialCharacter display "/[^*/]"me=e-1
syn match cUserSpecialCharacter display "/$"
hi def link cUserSpecialCharacter cCharacter


let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_menu_selection_background = 'yellow'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_colors_override = {
			\ 'bg0':              ['#191d20',   '234'],
			\ 'bg1':              ['#262727',   '235'],
			\ 'bg2':              ['#262727',   '235'],
			\ 'bg3':              ['#3c3836',   '237'],
			\ 'bg4':              ['#3c3836',   '237'],
			\ 'bg5':              ['#504945',   '239'],
			\ 'bg_statusline1':   ['#1f2428',   '235'],
			\ 'bg_statusline2':   ['#32302f',   '235'],
			\ 'bg_statusline3':   ['#504945',   '239'],
			\ 'bg_diff_green':    ['#32361a',   '22'],
			\ 'bg_visual_green':  ['#333e34',   '22'],
			\ 'bg_diff_red':      ['#3c1f1e',   '52'],
			\ 'bg_visual_red':    ['#442e2d',   '52'],
			\ 'bg_diff_blue':     ['#0d3138',   '17'],
			\ 'bg_visual_blue':   ['#2e3b3b',   '17'],
			\ 'bg_visual_yellow': ['#473c29',   '94'],
			\ 'bg_current_word':  ['#32302f',   '236'],
			\ 'fg0':              ['#d4be98',   '223'],
			\ 'fg1':              ['#ddc7a1',   '223'],
			\ 'red':              ['#ea6962',   '167'],
			\ 'orange':           ['#EBCB8B',   '208'],
			\ 'yellow':           ['#d8a657',   '214'],
			\ 'green':            ['#A3BE8C',   '142'],
			\ 'aqua':             ['#D08770',   '108'],
			\ 'blue':             ['#7C9C90',   '109'],
			\ 'purple':           ['#e78a4e',   '175'],
			\ 'bg_red':           ['#ea6962',   '167'],
			\ 'bg_green':         ['#a9b665',   '142'],
			\ 'bg_yellow':        ['#d8a657',   '214'],
			\ 'grey0':            ['#7c6f64',   '243'],
			\ 'grey1':            ['#928374',   '245'],
			\ 'grey2':            ['#a89984',   '246'],
			\ 'none':             ['NONE',      'NONE']
			\ }
colorscheme gruvbox-material

hi cUserSpecialCharacter ctermfg=15 guifg=#D08770
"autocmd! ColorScheme * highlight NormalFloat guibg=#191d20
"autocmd! ColorScheme * highlight FloatBorder guifg=#191d20 guibg=#191d20
"hi CocExplorerNormalFloatBorder guifg=#414347 guibg=#272B34
"hi CocExplorerNormalFloat guibg=#272B34
"hi CocExplorerSelectUI guibg=#EBCB8B guifg=black
hi Pmenu guibg=#2A2E31


" ==============================================================================
" ------------------------------------ LUA -------------------------------------
" ==============================================================================
lua << EOF

--- LSP
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()

--- NEOSCROLL
require('neoscroll').setup{}
local t = {} -- Syntax: t[keys] = {function, {function arguments}}
t['<PageUp>'] = {'scroll', {'-vim.wo.scroll', 'true', '100', [['sine']]}}
t['<PageDown>'] = {'scroll', { 'vim.wo.scroll', 'true', '100', [['sine']]}}
require('neoscroll.config').set_mappings(t)

--- LEAP
require('leap').set_default_keymaps()

--- LUALINE
require('lualine').setup{options = {icons_enabled = false}}

--- BUFFERLINE
require'bufferline'.setup{
highlights = { fill = {bg = '#1f2428'}},
options = { show_close_icon = false, show_buffer_close_icons = false,
offsets = {{
filetype   = "neo-tree",
text       = " [     ]",
text_align = "left"
}}
}
}
--- NUMB
require('numb').setup()

EOF
