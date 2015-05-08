(bundle auto-async-byte-compile
  :features auto-async-byte-compile
  ;;自動バイトコンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  (setq eldoc-idle-delay 0.2) ;すぐに表示したい
  (setq eldoc-minor-mode-string "") ;モードラインにElDocと表示しない
  ;; find-functionをキー割り当てする
  (find-function-setup-keys))

(bundle ggtags
  ;;M-x imenu(jump to function)
  ;;M-.
  ;;install 'global'
  :features ggtags
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p
                     'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1)))))

;; -----------------------------------------------------------
;; pair input
(defun insert-bracket-pair (leftBracket rightBracket)
  (if (region-active-p)
      (let ((p1 (region-beginning))
	    (p2 (region-end)))
	(goto-char p2)
	(insert rightBracket)
	(goto-char p1)
	(insert leftBracket)
	(goto-char (+ p2 2)))
    (progn
      (insert leftBracket rightBracket)
      (backward-char 1))))
(defun insert-pair-brace () (interactive) (insert-bracket-pair "{" "}") )
(defun insert-pair-paren () (interactive) (insert-bracket-pair "(" ")") )
(defun insert-pair-double-straight-quote () (interactive) (insert-bracket-pair "\"" "\"") )
(defun insert-pair-single-straight-quote () (interactive) (insert-bracket-pair "'" "'") )
(defun insert-pair-bracket () (interactive) (insert-bracket-pair "[" "]") )
(defun insert-pair-angle-bracket () (interactive) (insert-bracket-pair "<" ">") )
(define-key global-map "{" 'insert-pair-brace)
(define-key global-map "(" 'insert-pair-paren)
(define-key global-map "\"" 'insert-pair-double-straight-quote)
(define-key global-map "'" 'insert-pair-single-straight-quote)
(define-key global-map "[" 'insert-pair-bracket)
(define-key global-map "<" 'insert-pair-angle-bracket)
;; -----------------------------------------------------------
;;M-x which-func-mode
;;always show current func name
;;to change color andsoon M-x customize-group RET which-Func
(which-function-mode 1)
(delete (assoc 'which-function-mode mode-line-format) mode-line-format)
(setq-default header-line-format (which-function-mode ("" which-function-format)))

;; git-gutter(use *-fringe to work with linum-mode)
(bundle! git-gutter-fringe
  (global-git-gutter-mode t))

;; flycheck
(bundle flycheck
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; eldoc
(setq-default eldoc-idle-delay 0.1
              eldoc-echo-area-use-multiline-p t
              flycheck-display-errors-delay 0.2)
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook #'turn-on-eldoc-mode))
(bundle c-eldoc
  (dolist (hook '(c-mode-hook c++-mode-hook))
    (add-hook hook #'(lambda ()
                       (set (make-local-variable 'eldoc-idle-delay) 0.3)
                       (c-turn-on-eldoc-mode)))))
(bundle eldoc-extension)
