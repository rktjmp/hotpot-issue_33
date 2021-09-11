(if (pcall #(require :rex_pcre2))
    (print :required-in-macro :OK)
    (print :required-in-macro :FAIL))
{}
