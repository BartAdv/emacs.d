(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map (kbd "C-c p") 'find-file-in-project)
(define-key global-map (kbd "C-c f") 'find-file)

(ido-mode t)

(package-require 'ag)

(defun rotators (pass)
  (interactive "sKey: ")
  (erc :server "pine.forestnet.org" :port 6667 :nick "BartAdv")
  (erc-join-channel (concat "Rotators" " " pass)))

(provide 'global)
