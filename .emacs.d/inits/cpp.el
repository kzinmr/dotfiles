;;;C
;; c-mode, c++-mode, java-mode
;; http://d.hatena.ne.jp/i_s/20091026/1256557730
(add-hook 'c-mode-common-hook
                   '(lambda ()
                        (setq indent-tabs-mode nil)
                        (setq tab-width 4)))
;;#ifdef 部分を隠す
(add-hook 'c-mode-common-hook 'hide-ifdef-mode)

;; auto-complete-c-headers
;;`gcc -xc -E -v -` or `gcc -xc++ -E -v -`
(bundle! 'auto-complete-c-headers
  (defun my:ac-c-header-init ()
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.9/include"))
  (defun my:ac-c++-header-init ()
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories '"/usr/include/c++/4.9"))
  (add-hook 'c-mode-hook 'my:ac-c-header-init)
  (add-hook 'c++-mode-hook 'my:ac-c++-header-init))

;; Google's C/C++ style for c-mode
;; (bundle! google-c-style
;;   (add-hook 'c-mode-common-hook 'google-set-c-style)
;;   (add-hook 'c-mode-common-hook 'google-make-newline-indent))
;; flymake-google-cpplint-load
;; https://github.com/flycheck/flycheck-google-cpplint
;; pip install cpplint
(bundle! flycheck/flycheck-google-cpplint)
(eval-after-load 'flycheck
  '(progn
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.
     (flycheck-add-next-checker 'c/c++-cppcheck
                                '(warnings-only . c/c++-googlelint))
     (custom-set-variables
      '(flycheck-c/c++-googlelint-executable "/usr/local/bin/cpplint")
      '(flycheck-googlelint-verbose "3")
      '(flycheck-googlelint-filter "-whitespace,+whitespace/braces")
      '(flycheck-googlelint-root "project/src")
      '(flycheck-googlelint-linelength "120")
      )))

;;clang-format
(bundle! clang-format
  (global-set-key "\C-c\C-f" 'clang-format-region))


;; Semantic in CEDET
;; canbe called by company-semantic(this requires clang installed)
(semantic-mode 1)
; adds semantic as a suggestion backend to auto-complete
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)


;;gdb
(setq gdb-many-windows t)
;;compile、next-error、 gdbを簡単に呼び出す。
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (define-key c-mode-base-map "\C-c\C-c" 'comment-region)
	    (define-key c-mode-base-map "\C-c\M-c" 'uncomment-region)
	    (define-key c-mode-base-map "\C-cc" 'compile)
	    (define-key c-mode-base-map "\C-ce" 'next-error)
	    (define-key c-mode-base-map "\C-cd" 'gdb)
	    (define-key c-mode-base-map "\C-ct" 'toggle-source)
	    ))
