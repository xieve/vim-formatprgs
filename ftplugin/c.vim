augroup vimrcFileTypeC
  autocmd! * <buffer>
  if exists('##ShellFilterPost')
    autocmd ShellFilterPost <buffer> if v:shell_error | execute 'echom "shell filter returned error " . v:shell_error . ", undoing changes"' | undo | endif
  endif
augroup END



if executable('uncrustify')
  autocmd vimrcFileTypeC BufWinEnter <buffer> ++once let &l:formatprg = 'uncrustify -q -l CPP ' .
        \ (&textwidth > 0 ? ' --set code_width=' . &textwidth . ' --set cmt_width=' . &textwidth : '') .
        \ ' --set indent_columns=' . &shiftwidth . (&expandtab ? ' --set indent_with_tabs=0' : '') .
        \ (filereadable(expand('%')) ? ' --assume %:S' : '')
elseif executable('astyle')
  autocmd vimrcFileTypeC BufWinEnter <buffer> ++once let &l:formatprg='astyle --mode=c --style=google ' .
              \ ' --pad-oper --pad-header --unpad-paren --align-pointer=name --align-reference=name --add-brackets --suffix=none ' .
              \ (&textwidth > 0 ? ' --max-code-length=' . &textwidth : '') .
              \ ' --indent=spaces=' . &shiftwidth . (&expandtab ? ' --convert-tabs' : '')
elseif executable('clang-format')
  let &l:formatprg = 'clang-format --assume-filename=%:S --style=Google'
endif
