;;;Python
(setenv "PYTHONPATH" "/usr/bin/python")
(add-hook 'python-mode-hook
                   '(lambda ()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)))

(define-key global-map
  "\C-cp" 'run-python)

;; Another python mode options:
;; https://github.com/python-rope/ropemacs
;; https://github.com/proofit404/anaconda-mode

;; Elpy.el
;;Elpy does not use Pymacs, Ropemacs and Ropemode anymore,
;;but instead provides its own Python interface with the elpy package on PyPI.
;pip install --user rope jedi flake8 (importmagic)
; Inline code completion (company-mode)
; Show function signatures (ElDoc)
; Syntax Error Highlighting and PEP8 Highlighting (Flymake)
; Display indentation markers (highlight-indentation)
; Show the virtualenv in the mode line (pyvenv)
; Expand code snippets (YASnippet)
; Auto-complete is brought in by jedi and rope.
; Simultaneous Editing is brought in by iedit.el.
; Code block shifting: C-c > or C-c <
; Automatic import is brought in by importmagic (disabled dueto error)
(bundle elpy
  (elpy-enable))
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
;; use flycheck insteadof flymake
(when (require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake))

;pip install autopep8
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
