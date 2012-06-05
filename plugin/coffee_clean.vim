" Maintainer:  Brendan Erwin <brendanjerwin@gmail.com>
" URL:         http://github.com/tnwinc/vim-coffee-clean
" License:     MIT

function! CoffeeClean()
    let save_cursor = getpos(".")

    "general puncuation spacing cleanup
    "
    "Missing spaces
    silent! %s/\v','/', '/g
    silent! %s/\v","/", "/g
    silent! %s/\v:(\w)(['"].*)@<!/: \1/g
    silent! %s/\v:\@(['"].*)@<!/: @/g

    "ensure space after =
    silent! %s/\v\={/= {/g
    silent! %s/\v\=(/= (/g
    silent! %s/\v\=\[/= [/g

    "Extra spaces
    silent! %s/\v\s+\=\s+/ = /g
    silent! %s/\v(\S)\s+,/\1,/g
    silent! %s/\(\w\) ,/\1,/g


    "use single quotes for 'normal' strings, leave double quotes for
    "interpolated strings
    " silent! %s/"\([^#"']\+\)"/'\1'/g
    silent! %s/""/''/g

    "remove extra spaces around braces
    silent! %s/\v(\S)\s+\]/\1]/g
    silent! %s/\(\w\) ]/\1]/g
    silent! %s/\[ /[/g
    silent! %s/( /(/g
    silent! %s/\v(\S)\s+\)/\1)/g
    silent! %s/\(\w\) )/\1)/g


    "lambdas
    "
    "always remove a space before the rocket
    silent! %s/)\s*->/)->/g
    silent! %s/)\s*=>/)=>/g
    silent! %s/,\s*->/, ->/g
    silent! %s/,\s*=>/, =>/g

    "cleanup lambdas as contained in parens. ensure a space to make it stand
    "out
    silent! %s/\v\(\((\w+)\)-\>/( (\1)->/g
    silent! %s/\v\(\((\w+)\)=\>/( (\1)=>/g

    "a parameterless lambda should always have a space in front
    silent! %s/\v:-\>/: ->/g
    silent! %s/\v:\=\>/: =>/g

    "simple cleanups for common stuff
    silent! %s/'use strict';/'use strict'/g
    silent! %s/@$/this/

    call setpos('.', save_cursor)
endfunction

autocmd BufWritePre *.coffee call CoffeeClean()
