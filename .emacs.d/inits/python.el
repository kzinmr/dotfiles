;;;Python
(add-hook 'python-mode-hook
                   '(lambda ()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)))
(bundle! pymacs)
;; (bundle! ropemacs)
;; (eval-after-load 'auto-complete-config
;;   '(progn
;;      (ac-config-default)
;;      (when (file-exists-p (expand-file-name "~/.emacs.d/el-get/pymacs"))
;;        (ac-ropemacs-initialize)
;;        (ac-ropemacs-setup))))
;; (eval-after-load 'auto-complete-autoloads
;;   '(progn
;;      (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
;;      (add-hook 'python-mode-hook
;; 	       (lambda ()
;; 		 (require 'auto-complete-config)
;; 		 (add-to-list 'ac-sources 'ac-source-ropemacs)
;; 		 (auto-complete-mode)))))

(define-key global-map
  "\C-cp" 'run-python)

(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map (kbd "\C-m") 'newline-and-indent)
            (define-key python-mode-map (kbd "RET") 'newline-and-indent)))
;pip install autopep8
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;pip install --user rope jedi flake8
(bundle elpy
  (elpy-enable))

;pip install --user pyflakes
; flycheck 
;; (bundle flymake)
;; (bundle flymake-cursor)
;; (bundle flymake-easy)
;; (bundle flymake-python-pyflakes)

(require 'tramp-cmds)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
     ; Make sure it's not a remote buffer or flymake would not work
     (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy ;not known
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "pyflakes" (list local-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
 
(add-hook 'python-mode-hook
          (lambda ()
            (flycheck-mode t)))
