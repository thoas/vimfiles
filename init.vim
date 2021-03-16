call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-haml'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle', 'tag': '5.0.0' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar', { 'tag': 'v2.6.1' }
Plug 'othree/html5.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'ervandew/supertab'
call plug#end()

silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

source $HOME/.vim/settings.vim
source $HOME/.vim/map.vim
source $HOME/.vim/autocmd.vim
source $HOME/.vim/plugins.vim
