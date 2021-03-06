" Disable stupid html rendering
fun! s:SelectHTML()
    let n = 1
    while n < 50 && n < line("$")
        " check for django
        if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
            set ft=htmldjango
            return
        endif
        let n = n + 1
    endwhile
    " go with html
    set ft=html
endfun

function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  " autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" Only do this part when compiled with support for autocommands {{{
if has("autocmd")
    " Enable file type detection
    filetype on
    filetype indent on
    filetype plugin on

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal                      ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal                      ts=2 sts=2 sw=2 expandtab

    " Customisations based on house-style (arbitrary    )
    autocmd FileType html                               setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css                                setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType sass                               setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript                         setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType scala                              setlocal ts=2 sts=2 sw=2 expandtab

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss                    setfiletype xml

    au filetype html                                    set omnifunc=htmlcomplete#CompleteTags
    au filetype css                                     set omnifunc=csscomplete#CompleteCSS
    au filetype javascript                              set omnifunc=javascriptcomplete#CompleteJS
    au filetype c                                       set omnifunc=ccomplete#Complete
    au filetype php                                     set omnifunc=phpcomplete#CompletePHP
    au filetype ruby                                    set omnifunc=rubycomplete#Complete
    au filetype sql                                     set omnifunc=sqlcomplete#Complete
    au filetype python                                  set omnifunc=python3complete#Complete colorcolumn=80
    au filetype xml                                     set omnifunc=xmlcomplete#CompleteTags

    au! BufRead,BufNewFile *.es6                        setfiletype javascript
    au! BufRead,BufNewFile *.py                         setfiletype python.django
    au! BufRead,BufNewFile *.php                        setfiletype php
    au! BufRead,BufNewFile *.phps                       setfiletype php
    au! BufRead,BufNewFile *.php.html                   setfiletype htmlphp
    au! BufRead,BufNewFile *.tpl.html,*.tpl             setfiletype htmlphp
    au! BufRead,BufNewFile *.phtml                      setfiletype htmlphp
    au! BufNewFile,BufRead *.html,*.htm                 call s:SelectHTML()
    au BufRead,BufNewFile *.pp                          set filetype=puppet
    autocmd BufNewFile,BufRead *.jade setf haml

    au! BufRead,BufNewFile *.scala.html                 setfiletype scala
    au! BufRead,BufNewFile *.json.j2                    setfiletype json
    au! BufRead,BufNewFile *.yml.j2                     setfiletype yaml

    augroup markdown
        au! BufRead,BufNewFile *.mkd                    setfiletype mkd
        au! BufRead,BufNewFile *.md                     setfiletype mkd
        au! BufRead,BufNewFile *.mdown                  setfiletype mkd
        au! BufRead,BufNewFile *.markdown               setfiletype mkd
    augroup END

    au! BufRead,BufNewFile *.conf                       setfiletype apache
    au! BufRead,BufNewFile *.as                         setfiletype javascript
    au! BufRead,BufNewFile *.js                         setfiletype javascript
    au BufNewFile,BufRead *.json                        setfiletype json

    autocmd BufEnter *.txt                              set filetype=text
    autocmd BufEnter *.todo                             set filetype=todo

    au FileType go                                      set noexpandtab
    au FileType go                                      set shiftwidth=4
    au FileType go                                      set softtabstop=4
    au FileType go                                      set tabstop=4

    au BufNewFile,BufRead admin.py                      setlocal filetype=python.django
    au BufNewFile,BufRead urls.py                       setlocal filetype=python.django
    au BufNewFile,BufRead models.py                     setlocal filetype=python.django
    au BufNewFile,BufRead views.py                      setlocal filetype=python.django
    au BufNewFile,BufRead settings.py                   setlocal filetype=python.django
    au BufNewFile,BufRead forms.py                      setlocal filetype=python.django

    au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby

    "au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()
endif
" }}}
