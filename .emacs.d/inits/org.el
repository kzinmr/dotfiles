;;; init-org.el --- org-mode config
;;;org-mode
;;M-x org-insert-heading-dwim
;;C-RET, C-u C-RET, C-u C-u C-RET
(require 'bundle)
(bundle org
  :features (org org-install ob)
)
;; (defun org-insert-upheading (arg)
;;   (interactive "P")
;;   (org-insert-heading arg)
;;   (cond ((org-on-heading-p) (org-do-promote))
;; 	((org-insert-item-p) (org-insert-item -1))))
;; (defun org-insert-heading-dwim (arg)
;;   (interactive "p")
;;   (case arg
;;     (4 (org-insert-subheading nil)) ;C-u
;;     (16 (org-insert-upheading nil)) ;C-u C-u
;;     (t (org-insert-heading nil))))
;; (define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)
;; -----------------------------------------------------------
;;org-babel
;; #+BEGIN_SRC emacs-lisp
;; code
;; #+END_SRC
;; C-c '
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)))
(add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))
(defvar org-babel-default-header-args:clojure
  '((:results . "silent") (:tangle . "yes")))
;; (defun org-babel-execute:clojure (body params)
;;   (lisp-eval-string body)
;;   "Done!")
(provide 'ob-clojure)
(setq org-src-fontify-natively t)
(setq org-confirm-babel-evaluate nil)

;;yasnipet for org-mode
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (org-set-local 'yas/trigger-key [tab])
;;             (define-key yas/keymap [tab] 'yas/next-field-group)))

;; (defun yas/org-very-safe-expand ()
;; (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
;; (add-hook 'org-mode-hook
;;   (lambda ()
;;     (org-set-local 'yas/trigger-key [tab])
;;     (define-key yas/keymap [tab] 'yas/next-field-group)
;;     ;;yasnippet (using the new org-cycle hooks)
;;     (setq ac-use-overriding-local-map t)
;;     (make-variable-frame-local 'yas/trigger-key)
;;     (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)))

;;M-x org-remember
;(require 'org)
(setq org-directory "~/memo/")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
(setq org-remember-templates
      '(("Note" ?n "** %?\n  %i\n  %t" nil "Inbox")
	("Todo" ?t "** TODO %?\n  %i\n  %a\n %t" nil "Inbox")))
;select template: [n]ote [t]odo
;;refer to ChangeLog(C-u C-x 4 a), hown(http://howm.sourceforge.jp/index-j.html), Planner(http://download.gna.org/planner-el)
;;; init-org.el ends here
