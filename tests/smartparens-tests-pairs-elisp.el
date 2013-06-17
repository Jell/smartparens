(require 'smartparens-tests-env)

(defvar sp-test-get-paired-expression-elisp
  '(("'(foo)" 2 7 "(" ")" "'")
    ("`(foo)" 2 7 "(" ")" "`")
    (",@(foo)" 3 8 "(" ")" ",@")
    (",[vector foo (bar) lolz]" 2 25 "[" "]" ",")
    ))

(ert-deftest sp-test-get-paired-expression-elisp ()
  "Test basic paired expressions in `elisp-mode'."
  (sp-test-setup-paired-expression-env-elisp
   (--each sp-test-get-paired-expression
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) nil nil))
   (--each sp-test-get-paired-expression-elisp
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) nil nil))))

(ert-deftest sp-test-get-paired-expression-elisp-backward ()
  (sp-test-setup-paired-expression-env-elisp
   (--each sp-test-get-paired-expression
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) t nil))
   (--each sp-test-get-paired-expression-elisp
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) t nil))))

(defvar sp-test-get-paired-expression-elisp-fail
  '("'(foo"
    "`(foo"
    ",@(foo"
    ))

(defvar sp-test-get-paired-expression-elisp-backward-fail
  '("'foo)"
    "`foo)"
    ",@foo)"
    ))

(ert-deftest sp-test-get-paired-expression-elisp-fail ()
  (sp-test-setup-paired-expression-env-elisp
   (--each sp-test-get-paired-expression-fail
     (sp-test-setup-paired-sexp it nil nil t))
   (--each sp-test-get-paired-expression-elisp-fail
     (sp-test-setup-paired-sexp it nil nil t))))

(ert-deftest sp-test-get-paired-expression-elisp-backward-fail ()
  (sp-test-setup-paired-expression-env-elisp
   (--each sp-test-get-paired-expression-backward-fail
     (sp-test-setup-paired-sexp it nil t t))
   (--each sp-test-get-paired-expression-elisp-backward-fail
     (sp-test-setup-paired-sexp it nil t t))))

(defmacro sp-test-setup-paired-expression-env-elisp (&rest forms)
  `(sp-test-setup-paired-expression-env
     sp--test-basic-pairs
     emacs-lisp-mode
     emacs-lisp-mode-hook
     ,@forms))

(provide 'smartparens-tests-pairs-elisp)
