(if (pcall #(require :rex_pcre2))
    (print :required-in-module :OK)
    (print :required-in-module :FAIL))

(import-macros {} :test-macro)
