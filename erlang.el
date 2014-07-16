(setq load-path (cons "/usr/lib/erlang/lib/tools-2.6.15/emacs" load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)

(substitute-unicode 'erlang-mode
		    (list (cons "\\b\\(fun\\)\\b" 'lambda)))

(add-to-list 'load-path "~/emacs/edts")
(require 'edts-start)

(provide 'erlang)
