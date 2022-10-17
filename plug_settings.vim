" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    settings.vim                                       :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wsz </var/spool/mail/wsz>                  +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/02/26 22:50:51 by wsz               #+#    #+#              "
"    Updated: 2022/02/26 22:50:53 by wsz              ###   ########.fr        "
"                                                                              "
" **************************************************************************** "
"
"

" ==============================================================================
" ------------------------- VIM WORKSPACE ("SESSION") --------------------------
" ==============================================================================
"
"
nnoremap <leader>ss :ToggleWorkspace<CR>
nnoremap <leader>sc :CloseHiddenBuffers<CR>
"let g:workspace_autocreate = 1"
let g:workspace_session_directory = $HOME . '/.vim/sessions/'

"let g:workspace_session_disable_on_args = 1

" ==============================================================================
" -------------------------------- COC EXPLORER --------------------------------
" ==============================================================================

" have vim start coc-explorer if vim started with folder
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'CocCommand explorer' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"function! s:DisableFileExplorer()
    "au! FileExplorer
"endfunction

"function! s:OpenDirHere(dir)
    "if isdirectory(a:dir)
	"exec "silent CocCommand explorer --current-buffer" . a:dir
    "endif
"endfunction

"" Taken from vim-easytree plugin, and changed to use coc-explorer
"augroup CocExplorerDefault
    "autocmd VimEnter * call <SID>DisableFileExplorer()
    "autocmd BufEnter * call <SID>OpenDirHere(expand('<amatch>'))
"augroup end

" ==============================================================================
" --------------------------------- PROSESSION ---------------------------------
" ==============================================================================

"let g:prosession_ignore_dirs = [
			"\ '/home/wsz',
			"\ '~/.dot/config/nvim',
			"\]


" ==============================================================================
" ---------------------------------- FLOATERM ----------------------------------
" ==============================================================================


let g:floaterm_width=0.9
let g:floaterm_height=0.9
nnoremap   <leader>tg   :FloatermNew<CR>
tnoremap   <leader>tg   <C-\><C-n>:FloatermNew<CR>
nnoremap   <leader>tr   :FloatermPrev<CR>
tnoremap   <leader>tr   <C-\><C-n>:FloatermPrev<CR>
nnoremap   <leader>ty   :FloatermNext<CR>
tnoremap   <leader>ty   <C-\><C-n>:FloatermNext<CR>
nnoremap   <leader>tt   :FloatermToggle<CR>
tnoremap   <leader>tt   <F12>   <C-\><C-n>:FloatermToggle<CR>

" ==============================================================================
" --------------------------------- WORKSPACES ---------------------------------
" ==============================================================================

"" Plugin needs these options
set hidden
set sessionoptions+=globals

"" Switch among workspaces 1 through 10
noremap <silent> <leader>1 :WS 1<CR>
noremap <silent> <leader>2 :WS 2<CR>
noremap <silent> <leader>3 :WS 3<CR>
noremap <silent> <leader>4 :WS 4<CR>
noremap <silent> <leader>5 :WS 5<CR>
noremap <silent> <leader>6 :WS 6<CR>
noremap <silent> <leader>7 :WS 7<CR>
noremap <silent> <leader>8 :WS 8<CR>
noremap <silent> <leader>9 :WS 9<CR>
noremap <silent> <leader>0 :WS 10<CR>

"" Alternate between current and previous workspaces
noremap <silent> <leader><tab> :call WS_Backforth()<CR>

"" Show info line about workspaces
noremap <silent> <leader><space> :call WS_Line()<CR>

" ==============================================================================
" ---------------------------------- STARTIFY ----------------------------------
" ==============================================================================
"
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

"let g:startify_session_persistence = 1
"let g:startify_session_autoload = 1

" ==============================================================================
" --------------------------------- VIMSPECTOR ---------------------------------
" ==============================================================================

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

" ==============================================================================
" --------------------------------- SEARCH WEB ---------------------------------
" ==============================================================================
let g:openbrowser_search_engines = extend(
			\ get(g:, 'openbrowser_search_engines', {}),
			\ {
			\   'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
			\   'qt': 'https://doc.qt.io/qt-5/search-results.html?q={query}',
			\ },
			\ 'keep'
			\)

nnoremap <silent> <leader>osx :call openbrowser#smart_search(expand('<cword>'), "cppreference")<CR>
nnoremap <silent> <leader>osq :call openbrowser#smart_search(expand('<cword>'), "qt")<CR>



" TIDAL
"let g:tidal_target = "terminal"
" ==============================================================================
" ---------------------------------- CONTEXT -----------------------------------
" ==============================================================================

let g:context_border_char = ''

" ==============================================================================
" ----------------------------------- EMMET ------------------------------------
" ==============================================================================
" ?
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
			\  'javascript.jsx' : {
			\      'extends' : 'jsx',
			\  },
			\}

"################################################ "
"### LEXICAL SPELL CHECKER ### "
"################################################
"augroup lexical
"autocmd!
"autocmd FileType markdown,mkd call lexical#init()
"autocmd FileType textile call lexical#init()
"autocmd FileType text call lexical#init({ 'spell': 0 })
"augroup END
"let g:lexical#spelllang = ['en_us','fr']

"################################################ "
"### WILDER MENU ### "
"################################################

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

"################################################ "
"### RESTORE VIEW ### "
"################################################ "

set viewoptions=cursor,folds,slash,unix
let g:skipview_files = ['*\.vim']

"################################################ "
"### NCOC ### "
"################################################ "

":CocConfig >
"
"{
"	"clangd.inlayHints.enable": false,
"	"coc.preferences.semanticTokensHighlights": false,
"	"diagnostic.checkCurrentLine": true,
"	"codeLens.enable": true,
"	"diagnostic.virtualText": true,
"	"diagnostic.virtualTextCurrentLineOnly" : false,
"
"	"Lua": {
"		"workspace.library": {
"			"/usr/share/nvim/runtime/lua": true,
"			"/usr/share/nvim/runtime/lua/vim": true,
"			"/usr/share/nvim/runtime/lua/vim/lsp": true,
"		},
"		"diagnostics": {
"			"globals": ["vim"]
"		}
"	},
"}


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1):
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
"if has('nvim')
"inoremap <silent><expr> <c-space> coc#refresh()
"else
"inoremap <silent><expr> <c-@> coc#refresh()
"endif

"runtime! plugin/supertab.vim
"inoremap <s-tab>  <tab>
nnoremap gd       :call       CocActionAsync('doHover')<CR>
nnoremap gD       :call       CocActionAsync('jumpDefinition')<CR>
nmap     <silent> <C-k>       <Plug>(coc-diagnostic-prev)
nmap     <silent> <C-j>       <Plug>(coc-diagnostic-next)

"################################################# "
"### EASY ALIGN ###
"################################################ "

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map g=  gaip*=
map g\| gaip*\|
map g.  gaip*.
map g,  gaip*,
map g<Space> gaip*<Space>

"################################################ "
"### FOOTPRINTS ### "
"################################################ "

let g:footprintsColor            = '#2a2f31'
let g:footprintsTermColor        = '201'
let g:footprintsEasingFunction   = 'linear'
let g:footprintsHistoryDepth     = 33
let g:footprintsExcludeFiletypes = ['magit', 'neo-tree', 'diff']
let g:footprintsEnabledByDefault = 1
let g:footprintsOnCurrentLine    = 1

"################################################ "
"### AIRLINE ### "
"################################################ "

"let g:airline#extensions#tabline#enabled   = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme                        = 'gruvbox_material'
"let g:airline_theme='base16'
"let g:airline#extensions#tabline#formatter = 'default'
"
"################################################ "
"### RAINBOW BRACKETS ### "
"################################################ "

"map <C-b>                                  :RainbowToggle<CR>
"let g:rainbow_active = 1

"################################################ "
"### 42 HEADER ### "
"################################################ "

nmap <F12> :FortyTwoHeader<CR>
let b:fortytwoheader_user="wszurkow"
let b:fortytwoheader_mail="wszurkow@student.42.fr"

"################################################ "
"### HEX HIGHLIGHT### "
"################################################ "
"
nmap <F2>			<ESC>:ColorToggle<CR>

"################################################ "
"### NEO TREE ### "
"################################################ "

"nmap <C-p> <Cmd>CocCommand explorer<CR>
nmap <C-p> <Cmd>CocCommand explorer
			\ --toggle
			\ --sources=buffer+,file+
			"\ --open-action-strategy=vsplit
			"\ --quit-on-open
			\ <CR>


"nmap <C-l> :NeoTreeFocusToggle<CR>
"nnoremap <silent> <C-d> :NeoTreeFloatToggle<CR>
"defaults.lua
"      folder_closed = "",
"     folder_open = "",
"    default = "כּ",

"highlights.lua
"116:  create_highlight_group(M.DIRECTORY_ICON, {}, nil, "d8a657")

"################################################ "
"### VISUAL-MULTIPLE-CURSORS ### "
"################################################ "

let g:VM_maps = {}
let g:VM_maps["Select All"]                  = '\\a'
let g:VM_maps["Add Cursor Down"]             = '<S-Down>'
let g:VM_maps["Add Cursor Up"]               = '<S-Up>'
let g:VM_maps["Add Cursor At Pos"]           = '\\\'
let g:VM_maps['Find Under']                  = '<C-n>'
"let g:VM_maps['Find Subword Under']          = '<C-n>'
"let g:VM_maps["Start Regex Search"]          = '\\/'
"let g:VM_maps["Visual Regex"]                = '\\/'
"let g:VM_maps["Visual All"]                  = '\\a'
"let g:VM_maps["Visual Add"]                  = '\\a'
"let g:VM_maps["Visual Find"]                 = '\\f'
"let g:VM_maps["Visual Cursors"]              = '\\c'

"################################################ "
"### FZF ### "
"################################################ "

"call fzf#run(fzf#vim#with_preview({'options': ['--reverse'], 'down': '80%'}))

let g:fzf_preview_window = 'right:70%'

nnoremap <silent> <C-f> :Files<cr>
nnoremap <silent> <C-b> :Buffers<cr>
nnoremap <silent> <C-a> :Ag<cr>
nnoremap <silent> <C-l> :Lines<cr>

"################################################ "
"### UNDOTREE ### "
"################################################ "
"
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

"################################################ "
"### TOGGLE TERM ### "
"################################################ "

"autocmd TermEnter term://*toggleterm#*
			"\ tnoremap <silent><Leader>t <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>

"" By applying the mappings this way you can pass a count to your
"" mapping to open a specific window.
"" For example: 2<C-t> will open terminal 2
"nnoremap <silent><Leader>t <Cmd>exe v:count1 . "ToggleTerm height=20 direction=horizontal"<CR>
"nnoremap <silent><Leader>T <Cmd>exe v:count1 . "ToggleTerm height=20 direction=float"<CR>

"inoremap <silent><Leader>t <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

