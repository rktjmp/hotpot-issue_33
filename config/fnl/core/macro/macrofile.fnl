(fn double-quote [str]
  (string.format "\"%s\"" str))

(fn echo! [str]
  (vim.cmd (string.format "echom %s" (double-quote str))))

(fn warn! [str]
  (vim.cmd (string.format "
                          echohl WarningMsg
                          echom %s
                          echohl None
                          " (double-quote str))))

(let [(exists? _) (pcall require :rex_pcre2)]
  (if exists?
    (echo! "'rex_pcre2' module is available from macrofile.fnl")
    (warn! "'rex_pcre2' module is NOT available from macrofile.fnl")))

{}
