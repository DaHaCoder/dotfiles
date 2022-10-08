call plug#begin('~/.local/share/nvim/plugins')

" ALL PLUGINS
" ===========

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-vimtex'
"Plug 'glepnir/dashboard-nvim'
"Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons' 
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'lervag/vimtex'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" color schemes
" -------------
Plug 'haishanh/night-owl.vim'
Plug 'pineapplegiant/spaceduck'
Plug 'taDachs/kit.vim'
"Plug 'dracula/vim'
Plug 'DaHaCoder/helix.vim'
Plug 'DaHaCoder/dracula-helix-vim'

call plug#end()


" PLUGIN SETTINGS
" ===============


" basic settings
" --------------
syntax on
filetype plugin indent on
set encoding=utf-8
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set termguicolors
set background=dark
set updatetime=400
" --------------


" numbering
" --------- 
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter	 * set norelativenumber
augroup END
" --------- 


" cursorline
" ----------
set cursorline
"set cursorcolumn
" ----------


" splitting
" ---------
set splitbelow splitright
" ---------


" indentline
" ----------
" let g:indentLine_setColors = 0
" let g:indentLine_char = '¦'
" let g:indentLine_bgcolor_term = 202
" let g:indentLine_bgcolor_gui = '#FF5F00'
" let g:indentLine_concealcursor = ''
" let g:indentLine_conceallever = 2 
" ----------


" colors and themes
" -----------------
colorscheme dracula 
" -----------------


" airline 
" -------
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" -------


" coc
" ---
"coc.nvim works best on vim >= 8.2.0750 and neovim >= 0.5.0, consider upgrade your vim.
"You can add this to your vimrc to avoid this message:
let g:coc_disable_startup_warning = 1
"Note that some features may behave incorrectly
let g:coc_global_extensions = [
     \ 'coc-texlab'
     \]

" autocompletion with ENTER + TAB
"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next='<tab>'

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ <SID>check_back_space() ? "\<Tab>"  :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
" ---


" vim-latex-live-preview
" ----------------------
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'latexmk' . ''
let g:livepreview_use_biber = 1
" ----------------------


" vimtex 
" ------
"let g:vimtex_view_general_viewer = 'okular'
" ------


" ultisnips
" ---------
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']  " using Neovim
" ---------
