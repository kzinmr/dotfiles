; M-x kmacro-save
;; C-x (, macro, C-x ); C-xC-k n; macroname
(defvar kmacro-save-file "~/.emacs.d/inits/macro.el")
(defun kmacro-save (symbol)
  (interactive "SName for last kbd macro: ")
  (name-last-kbd-macro symbol)
  (with-current-buffer (find-file-noselect kmacro-save-file)
    (goto-char (point-max)) ;goto the end of .emacs
    (insert-kbd-macro symbol)
    (basic-save-buffer)))
