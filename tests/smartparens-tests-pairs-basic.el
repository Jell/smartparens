(require 'smartparens-tests-env)

(defvar sp-test-get-paired-expression
  '(("(foo bar)" 1 10 "(" ")" "")
    ("()" 1 3 "(" ")" "")
    ("(foo (bar) (baz) ((quux) (quo)) qua)" 1 37 "(" ")" "")
    ("\\{foo bar (baz) quux\\}" 1 23 "\\{" "\\}" "")
    ("\\{foo \\{bar baz\\} quux fux \\}" 1 30 "\\{" "\\}" "")
    ("[vector foo (bar) lolz]" 1 24 "[" "]" "")
    ))

(ert-deftest sp-test-get-paired-expression ()
  "Test basic paired expressions in `emacs-lisp-mode'."
  (sp-test-setup-paired-expression-env-basic
    (--each sp-test-get-paired-expression
      (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) nil nil))))

(ert-deftest sp-test-get-paired-expression-backward ()
  (sp-test-setup-paired-expression-env-basic
    (--each sp-test-get-paired-expression
      (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) t nil))))

(defvar sp-test-get-paired-expression-fail
  '("(foo bar"
    "("
    "(foo (bar) (baz) ((quux) (quo)) qua"
    ))

(defvar sp-test-get-paired-expression-backward-fail
  '("foo bar)"
    ")"
    "foo (bar) (baz) ((quux) (quo)) qua)"
    ))

(ert-deftest sp-test-get-paired-expression-fail ()
  (sp-test-setup-paired-expression-env-basic
    (--each sp-test-get-paired-expression-fail
      (sp-test-setup-paired-sexp it nil nil t))))

(ert-deftest sp-test-get-paired-expression-backward-fail ()
  (sp-test-setup-paired-expression-env-basic
    (--each sp-test-get-paired-expression-backward-fail
      (sp-test-setup-paired-sexp it nil t t))))

(defmacro sp-test-setup-paired-expression-env-basic (&rest forms)
  `(sp-test-setup-paired-expression-env
     sp--test-basic-pairs
     emacs-lisp-mode
     emacs-lisp-mode-hook
     ,@forms))

(provide 'smartparens-tests-pairs-basic)
