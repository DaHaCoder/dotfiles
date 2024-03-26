call plug#begin('~/.local/share/nvim/plugins')

" ALL PLUGINS
" ===========

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-vimtex'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'glepnir/dashboard-nvim'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'frabjous/knap'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/nerdtree'
" Plug 'emakman/nvim-latex-previewer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-lua/plenary.nvim'
Plug 'preservim/tagbar'
" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
" Plug 'ap/vim-css-color'
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
" Plug 'dracula/vim'
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

function! DeleteTrailingWhitespace()
    let l:view = winsaveview()
    silent! %s/\s\+$//e
    call winrestview(l:view)
endfunction

autocmd BufWritePre * call DeleteTrailingWhitespace()

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
let g:indentLine_char = '┊'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_color_gui = '#5A7296'
let g:markdown_syntax_conceal=0
let g:tex_conceal=''
let g:vim_json_conceal=0
" let g:indentLine_concealcursor = ''
" let g:indentLine_conceallever = 2

" require("indent_blankline").setup {
"     -- for example, context is off by default, use this to turn it on
"     show_current_context = true,
"     show_current_context_start = true,
" }

" vim.opt.list = true
" vim.opt.listchars:append"space:⋅"
" vim.opt.listchars:append"eol:↴"

" require("indent_blankline").setup {
"     show_end_of_line = true,
"     space_char_blankline =" ",
" }
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


" markdown-preview.nvim
" ---------------------
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

" ---------------------


" vim-latex-live-preview
" ----------------------
" let g:livepreview_previewer = 'okular'
" let g:livepreview_engine = 'pdflatex' . ''
" let g:livepreview_use_biber = 1
" let g:livepreview_cursorhold_recompile = 0
" ----------------------


" vimtex
" ------
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_vew_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_compiler_method = 'latexmk -pvc -pdf'
" ------


" ultisnips
" ---------
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']  " using Neovim
" ---------
