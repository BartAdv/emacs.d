(package-require 'idris-mode)

(add-hook 'idris-mode-hook
	  (lambda () (progn
		  (define-key idris-mode-map (kbd "C-c r") 'idris-load-file))))

(provide 'idris)
