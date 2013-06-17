(require 'smartparens-tests-env)

(defvar sp--test-ruby-pairs
  (sp-test-merge-pairs '((:open "def"   :close "end" :actions (insert wrap))
                         (:open "if"    :close "end" :actions (insert wrap))
                         (:open "do"    :close "end" :actions (insert wrap))
                         (:open "begin" :close "end" :actions (insert wrap)))))

(defvar sp-test-get-paired-expression-ruby
  '(("def end" 1 8 "def" "end" "")
    ("def foo bar if blaz end end" 1 28 "def" "end" "")
    ))

(ert-deftest sp-test-get-paired-expression-ruby ()
  "Test basic paired expressions in `ruby-mode'."
  (sp-test-setup-paired-expression-env-ruby
   (--each sp-test-get-paired-expression
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) nil nil))
   (--each sp-test-get-paired-expression-ruby
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) nil nil))))

(ert-deftest sp-test-get-paired-expression-ruby-backward ()
  (sp-test-setup-paired-expression-env-ruby
   (--each sp-test-get-paired-expression
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) t nil))
   (--each sp-test-get-paired-expression-ruby
     (sp-test-setup-paired-sexp (car it) (apply 'sp-test-make-pair (cdr it)) t nil))))

(defvar sp-test-get-paired-expression-ruby-fail
  '("def en"
    ))

(defvar sp-test-get-paired-expression-ruby-backward-fail
  '("de end"
    ))

(ert-deftest sp-test-get-paired-expression-ruby-fail ()
  (sp-test-setup-paired-expression-env-ruby
   (--each sp-test-get-paired-expression-fail
     (sp-test-setup-paired-sexp it nil nil t))
   (--each sp-test-get-paired-expression-ruby-fail
     (sp-test-setup-paired-sexp it nil nil t))))

(ert-deftest sp-test-get-paired-expression-ruby-backward-fail ()
  (sp-test-setup-paired-expression-env-ruby
   (--each sp-test-get-paired-expression-backward-fail
     (sp-test-setup-paired-sexp it nil t t))
   (--each sp-test-get-paired-expression-ruby-backward-fail
     (sp-test-setup-paired-sexp it nil t t))))

(defmacro sp-test-setup-paired-expression-env-ruby (&rest forms)
  `(sp-test-setup-paired-expression-env
     sp--test-ruby-pairs
     ruby-mode
     ruby-mode-hook
     ,@forms))

(provide 'smartparens-tests-pairs-ruby)
