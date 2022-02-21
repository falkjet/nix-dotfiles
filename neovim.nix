{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim-remote
  ];
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number
      set relativenumber
      set mouse=a
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
      set textwidth=80
      set expandtab
      set updatetime=300
      set signcolumn=number
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#ignore_bufadd_pat =
      \ '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
      let g:onedark_color_overrides = {"background":
      \ {"gui": "NONE", "cterm": "NONE", "cterm16": "NONE" }
      \ }
      colorscheme onedark

      let g:vimtex_view_general_viewer = 'evince'
      nnoremap <C-b> :CtrlPBuffer<CR>
      inoremap <C-b> <Esc>:CtrlPBuffer<CR>
      vnoremap <C-b> <Esc>:CtrlPBuffer<CR>
      tnoremap <C-b> <C-\><C-n>:CtrlPBuffer<CR>
      autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert

      let $GIT_EDITOR = 'nvr -cc split --remote-wait'
      autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=wipe

      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      inoremap <silent><expr> <c-space> coc#refresh()
      inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " Navigation
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      command! -nargs=0 Format :call CocActionAsync('format')
      command! -nargs=0 OrganizeImports :call CocActionAsync('runCommand', 'editor.action.organizeImport')

      lua require("gitsigns").setup()
    '';
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      vim-nix
      onedark-vim
      vimtex
      ctrlp-vim
      coc-nvim
      coc-python
      coc-emmet
      coc-vimtex
      coc-tsserver
      gitsigns-nvim
    ];
  };
}
