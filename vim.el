;; -*- lexical-binding: t -*-

;; Set C-u to scroll up (must be before require evil)
(setq evil-want-C-u-scroll t)

(package-require 'evil)
(evil-mode 1)

(setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
(setq evil-emacs-state-modes nil)

(defun move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))

(move-key evil-motion-state-map evil-normal-state-map (kbd "<SPC>"))
(move-key evil-motion-state-map evil-normal-state-map (kbd "<RET>"))
(move-key evil-motion-state-map evil-normal-state-map (kbd "TAB"))
(move-key evil-motion-state-map evil-normal-state-map (kbd "DEL"))

;; Note: lexical-binding must be t in order for this to work correctly.
(defun make-conditional-key-translation (key-from key-to translate-keys-p)
  "Make a Key Translation such that if the translate-keys-p function returns true, key-from translates to key-to, else key-from translates to itself. translate-keys-p takes key-from as an argument. "
  (define-key key-translation-map key-from
    (lambda (prompt)
      (if (funcall translate-keys-p key-from) key-to key-from))))

(defun translate-keys-p (key-from)
  "Returns whether conditional key translations should be active. See make-conditional-key-translation function. "
  (and ;; Only allow a non identity translation if we're beginning a Key Sequence.
   (not isearch-mode)
   (equal key-from (this-command-keys))
   (or (evil-motion-state-p) (evil-normal-state-p) (evil-visual-state-p))))

;; Translate the problematic keys to the function key Hyper:
(keyboard-translate ?\C-i ?\H-i)
;; Rebind then accordantly: 
(define-key evil-motion-state-map (kbd "H-i") 'evil-jump-forward)

(define-key evil-normal-state-map (kbd "<SPC>") nil)
(define-key evil-normal-state-map (kbd "<RET>") nil)
(define-key evil-normal-state-map (kbd "TAB") nil)
(define-key evil-normal-state-map (kbd "DEL") nil)

(make-conditional-key-translation (kbd "<SPC>") (kbd "C-c") 'translate-keys-p)
(make-conditional-key-translation (kbd "C-<SPC>") (kbd "C-x") 'translate-keys-p)
(make-conditional-key-translation (kbd "TAB") (kbd "C-w") 'translate-keys-p)

; BS in normal mode => C-x
(define-key evil-normal-state-map (kbd "DEL") 'execute-extended-command)

(define-key evil-normal-state-map (kbd "C-w TAB") 'other-window)
(define-key evil-normal-state-map (kbd "C-w b") 'ido-switch-buffer)

; colemak movement
(defun vim-colemak ()
  (interactive)
  (define-key evil-normal-state-map (kbd "n") 'evil-next-line)
  (define-key evil-normal-state-map (kbd "e") 'evil-previous-line)
  (define-key evil-normal-state-map (kbd "i") 'evil-forward-char)

  (define-key evil-visual-state-map (kbd "n") 'evil-next-line)
  (define-key evil-visual-state-map (kbd "e") 'evil-previous-line)
  (define-key evil-visual-state-map (kbd "i") 'evil-forward-char)

  (define-key evil-normal-state-map (kbd "j") 'evil-search-backward)
  (define-key evil-normal-state-map (kbd "k") 'evil-search-forward))

(defun vim-qwerty ()
  (interactive)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-line)
  (define-key evil-normal-state-map (kbd "l") 'evil-forward-char)

  (define-key evil-visual-state-map (kbd "j") 'evil-next-line)
  (define-key evil-visual-state-map (kbd "k") 'evil-previous-line)
  (define-key evil-visual-state-map (kbd "l") 'evil-forward-char)

  (define-key evil-normal-state-map (kbd "N") 'evil-search-backward)
  (define-key evil-normal-state-map (kbd "n") 'evil-search-forward))

(define-key evil-normal-state-map (kbd "<RET>") 'evil-insert)

;; Add to mode hooks when rebinding these
(defun rebind-evil-tag-navigation (map jump jump-back)
  (define-key evil-motion-state-map (kbd "C-]") nil)
  (define-key map (kbd "C-]") jump)
  (define-key evil-motion-state-map (kbd "C-t") nil)
  (define-key map (kbd "C-t") jump-back))

(package-require 'surround)
(global-surround-mode 1)

(provide 'vim)
