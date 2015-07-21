;; zsh like completion
(setq read-file-name-completion-ignore-case t)
;(bundle! zlc :url "http://github.com/mooz/emacs-zlc.git"
(require 'zlc)
  (zlc-mode t)
  (let ((map minibuffer-local-map))
    (define-key map (kbd "C-p") 'zlc-select-previous)
    (define-key map (kbd "C-n") 'zlc-select-next)
    (define-key map (kbd "<up>") 'zlc-select-previous-vertical)
    (define-key map (kbd "<down>") 'zlc-select-next-vertical)
    (define-key map (kbd "C-u") 'backward-kill-path-element));)

;;helm
;(bundle helm
(require 'cl-lib)
(require 'helm-config)
;  :features (helm cl-lib helm-config)
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
               (define-key helm-map (kbd "C-h") nil)));)
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     ; available option: 'same, 'other,'right, 'left, 'below, 'above
     (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
     (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
     (define-key helm-map (kbd "C-z") 'helm-select-action)
     (defconst helm-split-window-default-side 'other)
     ))
(helm-mode t)
;;[Display not ready]
(defun my/helm-exit-minibuffer ()
  (interactive)
  (helm-exit-minibuffer))
(eval-after-load "helm"
  '(progn
     (define-key helm-map (kbd "<RET>") 'my/helm-exit-minibuffer)))


;; auto completion like IntelliSense
(bundle! popup)
(bundle auto-complete
  :features (auto-complete auto-complete-config)
  (ac-config-default)
  (ac-set-trigger-key "TAB")
  (setq ac-auto-show-menu 0.5)

;;; 適用するメジャーモードを足す
  (add-to-list 'ac-modes 'c-mode)
;;; ベースとなるソースを指定
  (defvar my-ac-sources
    '(ac-source-yasnippet
      ac-source-abbrev
      ac-source-dictionary
      ac-source-words-in-same-mode-buffers))
;;; 個別にソースを指定
  (defun ac-c-mode-setup ()
    (setq-default ac-sources my-ac-sources))
  (add-hook 'c-mode-hook 'ac-c-mode-setup))
(eval-after-load 'auto-complete
  '(progn
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  ;;(add-to-list 'ac-sources 'ac-source-yasnippet)
  ;;complete from some other source
  ;;(save-excursion )tq ac-sources(whichis buffer-local var) "pre-defined symbbol"
  ;;ex.complete Emacs Lisp symbol in emacs-lisp-mode
  (defun emacs-lisp-ac-setup ()
    (setq ac-sources
          '(ac-source-words-in-same-mode-buffers
            ac-source-symbols)))
  (add-hook 'emacs-lisp-mode-hook 'emacs-lisp-ac-setup)))
(global-auto-complete-mode t)

;;; C-n / C-p で選択
(setq ac-use-menu-map t)
;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
(setf (symbol-function 'yas-active-keys)
      (lambda ()
        (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

(bundle! auto-complete-latex
;  (setq ac-l-dict-directory "~/.emacs.d/share/ac-l-dict/")
;  (add-to-list 'ac-modes 'foo-mode)
;  (add-hook 'foo-mode-hook 'ac-l-setup)
)
