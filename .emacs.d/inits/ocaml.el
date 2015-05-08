;;;OCaml
(bundle! caml)

;;tuareg-mode
;;C-c C-e:eval
;; (autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
;; (autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
;; (autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
;; -- Tuareg mode -----------------------------------------
;; Add Tuareg to your search path
;; set tuareg installation directory
;; (add-to-list 'load-path
;;  (expand-file-name "~/.emacs.d/elpa/tuareg-20131019.848"))
;; -- Tweaks for OS X -------------------------------------
;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; init scripts when invoking a sub-shell
(bundle tuareg
  :features tuareg
  (setq auto-mode-alist 
        (append '(("\\.ml[ily]?$" . tuareg-mode))
                auto-mode-alist))
  (add-hook 'tuareg-mode-hook 'auto-complete-mode))

(cond
 ((eq window-system 'ns) ; macosx
  ;; Invoke login shells, so that .profile or .bash_profile is read
  (setq shell-command-switch "-lc")))

;; -- opam and utop setup --------------------------------
;; Setup environment variables using opam
(defun opam-vars ()
  (let* ((x (shell-command-to-string "opam config env"))
	 (x (split-string x "\n"))
	 (x (remove-if (lambda (x) (equal x "")) x))
	 (x (mapcar (lambda (x) (split-string x ";")) x))
	 (x (mapcar (lambda (x) (car x)) x))
	 (x (mapcar (lambda (x) (split-string x "=")) x))
	 )
    x))
(dolist (var (opam-vars))
  (setenv (car var) (substring (cadr var) 1 -1)))
;; The following simpler alternative works as of opam 1.1
;; (dolist
;;    (var (car (read-from-string
;; 	       (shell-command-to-string "opam config env --sexp"))))
;;  (setenv (car var) (cadr var)))
;; Update the emacs path
(setq exec-path (split-string (getenv "PATH") path-separator))
;; Update the emacs load path
(push (concat (getenv "OCAML_TOPLEVEL_PATH")
	      "/../../share/emacs/site-lisp") load-path)
;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)

;; -- merlin setup ---------------------------------------
(unless (require 'merlin nil 'noerror)
  (setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
  (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
  ;; Enable Merlin for ML buffers
  (add-hook 'tuareg-mode-hook 'merlin-mode)
  ;; So you can do it on a mac, where `C-<up>` and `C-<down>` are used
  ;; by spaces.
  (define-key merlin-mode-map
    (kbd "C-c <up>") 'merlin-type-enclosing-go-up)
  (define-key merlin-mode-map
    (kbd "C-c <down>") 'merlin-type-enclosing-go-down)
  (set-face-background 'merlin-type-face "#88FF44"))
;; -- ocp-indent -----------------------------------------
;; (add-to-list 'load-path (concat
;;     (replace-regexp-in-string "\n$" ""
;;         (shell-command-to-string "opam config var share"))
;;     "/emacs/site-lisp"))
;; (setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
;; (load-file (concat opam-share "/typerex/ocp-indent/ocp-indent.el"))
;; (require 'ocp-indent)
