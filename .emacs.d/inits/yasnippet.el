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
     ;; 既存スニペットを挿入
     (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
     ;; 新規スニペットを作成するバッファを用意
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
