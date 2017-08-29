function! AllTestFiles()
  return glob(getcwd()."/test/**/test_*.vim", v:false, v:true)
endfunction

for test in AllTestFiles()
  execute "source ".test
endfor

