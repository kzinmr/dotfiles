;;; Code:

;; GOPATH and PATH
(add-to-list 'exec-path (expand-file-name "/opt/go/bin/"))
(add-to-list 'exec-path (expand-file-name "~/.go/bin"))

(bundle! 'go-mode
  ;; go-import-add (Default: C-c C-a)

  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; instead of godef-describe(Default: C-c C-d) ;; 引数や、戻り値などの定義を確認
  ;; needs gocode (go get -u github.com/nsf/gocode)
  (add-to-list 'load-path "~/.go/src/github.com/nsf/gocode/emacs")
  ;; auto-complete
  (require 'go-autocomplete)
  ;; company-mode
  (add-to-list 'company-backends 'company-go)
  ;; disable these
  ;; (custom-set-variables
  ;;  '(ac-go-expand-arguments-into-snippets nil) ; auto-complete
  ;;  '(company-go-insert-arguments nil))         ; company-mode

  ;; fly-check
  (add-hook 'go-mode-hook 'flycheck-mode)

  ;; eldoc
  ;; (add-hook 'go-mode-hook 'go-eldoc-setup)

  ;; godef-jump (Default: C-c C-j)
  (define-key go-mode-map (kbd "M-.") 'godef-jump)
  (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)

  ;; helm-tips
  (defvar my/helm-go-source
    '((name . "Helm Go")
      (candidates . (lambda ()
                      (cons "builtin" (go-packages))))
      (action . (("Show document" . godoc)
                 ("Import package" . my/helm-go-import-add)))))
  (defun my/helm-go-import-add (candidate)
    (dolist (package (helm-marked-candidates))
      (go-import-add current-prefix-arg package)))
  (defun my/helm-go ()
    (interactive)
    (helm :sources '(my/helm-go-source) :buffer "*helm go*"))

  ;; go-direx
  (bundle! 'go-direx
    (define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer)))
