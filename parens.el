;;; parens.el --- Paredit setup

;; Paredit for all lisps
(package-require 'paredit)
(add-lisp-hook (lambda ()
                 (paredit-mode 1)
		 (define-key paredit-mode-map (kbd "C-i") 'paredit-forward-slurp-sexp)))

;; Make paredit play nice with eldoc
(eval-after-load "eldoc"
  '(eldoc-add-command
    'paredit-backward-delete
    'paredit-close-round))

(package-require 'rainbow-mode)

(provide 'parens)
