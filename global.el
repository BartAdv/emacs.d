(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map (kbd "C-c p") 'find-file-in-project)
(define-key global-map (kbd "C-c f") 'find-file)

(ido-mode t)

(package-require 'ag)

(provide 'global)
