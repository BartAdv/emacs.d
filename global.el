(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map (kbd "C-c p") 'find-file-in-project)
(define-key global-map (kbd "C-x f") 'find-file)

(ido-mode t)

(provide 'global)
