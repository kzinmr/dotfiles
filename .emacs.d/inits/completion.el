;;; Completion settings

;helm
(bundle helm
  :features (helm cl-lib helm-config)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (setq helm-idle-delay             0.3
        helm-input-idle-delay       0.3
;        helm-exit-idle-delay 0
        helm-candidate-number-limit 1000
        helm-maybe-use-default-as-input t
        helm-c-locate-command "locate-with-mdfind %.0s %s"
        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-ff-search-library-in-sexp t
        helm-scroll-amount 8
        helm-ff-file-name-history-use-recentf t)
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  ;; Unset key C-h to use normal C-h
  (add-hook 'helm-before-initialize-hook
            '(lambda ()
               (define-key helm-map (kbd "C-h") nil))))
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     ; available option: 'same, 'other,'right, 'left, 'below, 'above
     (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
     (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
     (define-key helm-map (kbd "C-z") 'helm-select-action)
     (defconst helm-split-window-default-side 'other)
     ))
(helm-mode 1)
;;[Display not ready]
(defun my/helm-exit-minibuffer ()
  (interactive)
  (helm-exit-minibuffer))
(eval-after-load "helm"
  '(progn
     (define-key helm-map (kbd "<RET>") 'my/helm-exit-minibuffer)))

;; auto completion like IntelliSense
(bundle! company
  (global-company-mode 1) ;特定のmodeだけで有効にしたいときは消して add-hook
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 2) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下から一番上に戻る
  ;; (setq company-idle-delay nil) ;;手動補完 M-x company-complete
)
(bundle! pos-tip)
(bundle! company-quickhelp
  (company-quickhelp-mode 1))
;; (bundle! company-statistics
;;   (setq company-transformers
;;         '(company-sort-by-statistics company-sort-by-backend-importance)))

;; default backends
;; (company-bbdb ;; address book for nearly every email and news client
;;  company-nxml
;;  company-css
;;  company-eclim ;; eclipse from emacs
;;  company-semantic ;;
;;  company-clang
;;  company-xcode ;;completion back-end for Xcode projects
;;  company-cmake
;;  company-capf
;;  (company-dabbrev-code company-gtags company-etags company-keywords)
;;  company-oddmuse ;;for editting pages on Oddmuse wikis (such as EmacsWiki)
;;  company-files
;;  company-dabbrev)
(bundle! company-math
  ;; (add-to-list 'company-backends 'company-math-symbols-unicode)
  (defun my-latex-mode-setup ()
    (setq-local company-backends
                (append '(company-math-symbols-latex company-latex-commands)
                        company-backends)))
  (add-hook 'tex-mode-hook 'my-latex-mode-setup)
)
(bundle! company-jedi
  ;; :features (company-jedi jedi-core)
  ;; (setq jedi:complete-on-dot t)
  ;; (setq jedi:use-shortcuts t)
  ;; (add-hook 'python-mode-hook 'jedi:setup)
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook)
)


;; local configuration for TeX modes

(defun company-my-backend (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (pcase command
    (`interactive (company-begin-backend 'company-my-backend))
    (`prefix (when (looking-back "foo\\>")
              (match-string 0)))
    (`candidates (list "foobar" "foobaz" "foobarbaz"))
    (`meta (format "This value is named %s" arg))))

;; (bundle! popup)
;; (bundle auto-complete
;;   :features (auto-complete auto-complete-config)
;;   (ac-config-default)
;;   (ac-set-trigger-key "TAB")
;;   (setq ac-auto-show-menu 0.5)
;;   (setq ac-use-menu-map t)
;;   (add-to-list 'ac-modes 'c-mode)
;;   (defvar my-ac-sources
;;     '(ac-source-yasnippet
;;       ac-source-abbrev
;;       ac-source-dictionary
;;       ac-source-words-in-same-mode-buffers))
;;   (defun ac-c-mode-setup ()
;;     (setq-default ac-sources my-ac-sources))
;;   (add-hook 'c-mode-hook 'ac-c-mode-setup))
;; (eval-after-load 'auto-complete
;;   '(progn
;;   (define-key ac-complete-mode-map "\C-n" 'ac-next)
;;   (define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;   ;;(add-to-list 'ac-sources 'ac-source-yasnippet)
;;   ;;complete from some other source
;;   ;;(save-excursion )tq ac-sources(whichis buffer-local var) "pre-defined symbbol"
;;   ;;ex.complete Emacs Lisp symbol in emacs-lisp-mode
;;   (defun emacs-lisp-ac-setup ()
;;     (setq ac-sources
;;           '(ac-source-words-in-same-mode-buffers
;;             ac-source-symbols)))
;;   (add-hook 'emacs-lisp-mode-hook 'emacs-lisp-ac-setup)))
;; (global-auto-complete-mode t)
;; ;; avoid yasnippet key-binding error
;; (setf (symbol-function 'yas-active-keys)
;;       (lambda ()
;;         (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))
;; (bundle! auto-complete-latex)

; yasnippet
(bundle! dropdown-list)
(bundle! yasnippet
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"                 ; personal
	  "~/.emacs.d/el-get/yasnippet/snippets" ; default
	  "~/.emacs.d/el-get/yasnippet/yasmate/snippets" ; yasmate
	  ))
  (yas-global-mode 1))
;  (custom-set-variables '(yas-trigger-key "TAB"))
(eval-after-load 'yasnippet
  '(progn
     (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
     (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
     ;; 既存スニペットを閲覧・編集
     ;; yas-visit-snippet-file関数中の(yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))をコメントアウト
     (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
     (define-key yas-minor-mode-map (kbd "M-i") 'yas-expand)))
(eval-after-load 'helm
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (helm-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*helm yas/prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))))
;; snippet-mode for *.yasnippet files
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

; zsh like completion
(setq read-file-name-completion-ignore-case t)
(bundle! zlc :url "http://github.com/mooz/emacs-zlc.git"
  (zlc-mode t)
  (let ((map minibuffer-local-map))
    (define-key map (kbd "C-p") 'zlc-select-previous)
    (define-key map (kbd "C-n") 'zlc-select-next)
    (define-key map (kbd "<up>") 'zlc-select-previous-vertical)
    (define-key map (kbd "<down>") 'zlc-select-next-vertical)
    (define-key map (kbd "C-u") 'backward-kill-path-element)))
