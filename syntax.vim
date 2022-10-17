" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    syntax.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/02/27 14:46:05 by wszurkow          #+#    #+#              "
"    Updated: 2022/02/27 14:46:15 by wszurkow         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

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
hi cUserSpecialCharacter ctermfg=15 guifg=#D08770

"################################################ "
"### GRUVBOX MATERIAL ### "
"################################################ "
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
