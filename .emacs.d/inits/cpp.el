;;;C
;;gdb
(setq gdb-many-windows t)
;;compile、next-error、 gdbを簡単に呼び出す。
(add-hook 'c-mode-hook
	  (lambda ()
	    (define-key c-mode-base-map "\C-c\C-c" 'comment-region)
	    (define-key c-mode-base-map "\C-c\M-c" 'uncomment-region)
	    (define-key c-mode-base-map "\C-cc" 'compile)
	    (define-key c-mode-base-map "\C-ce" 'next-error)
p	    (define-key c-mode-base-map "\C-cd" 'gdb)
	    (define-key c-mode-base-map "\C-ct" 'toggle-source)
	    ))
;;auto-indentation
(add-hook 'c-mode-common-hook
	  '(lambda ()

	     (c-toggle-auto-state 1)))
;;#ifdef 部分を隠す
(require 'hideif)
(add-hook 'c-mode-common-hook 'hide-ifdef-mode)
