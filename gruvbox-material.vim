""" Gruvbox-material color scheme
"""
if has('termguicolors')
    set termguicolors
endif

" cursor
" let g:gruvbox_material_cursor = 'green' "auto, red, orange, yellow, green, aqua, blue, purple

"bold function name
let g:gruvbox_material_enable_bold = 1


" lazy loading
let g:gruvbox_material_better_performance = 1


" italics
" let g:gruvbox_material_enable_italic = 1
" italic comments
" let g:gruvbox_material_disable_italic_comment = 1

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_ui_contrast = 'high' "low

"" Set contrast
if has('termguicolors') "important
    set termguicolors
endif

" Dark/light version
set background=dark "light

" Contrast, 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard' "should be placed before 'colorscheme gruvbox-material'
colorscheme gruvbox-material

