;;; theme.el --- Appearance matters

;; Let's see what we're running on
(setq on-console (null window-system))

;; No splash screen
(setq inhibit-startup-message t)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Some X11 setup
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

;; Show line numbers in buffers
(global-linum-mode 0)
(setq linum-format (if on-console "%4d " "%4d"))

;; Show column numbers in modeline
(setq column-number-mode t)

;; Redefine linum-on to ignore terminal buffers, because just turning
;; it off in term-mode-hook doesn't work.
(setq linum-disabled-modes
      '(term-mode slime-repl-mode magit-status-mode help-mode nrepl-mode
                  xwidget-webkit-mode revealjs-mode erlang-shell-mode))
(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes))
    (linum-mode 1)))

;; Highlight current line
(global-hl-line-mode)

;; git-gutter-fringe
(package-require 'git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode t)
;; (setq git-gutter-fr:side 'right-fringe)

;; Set custom theme path
(setq custom-theme-directory (concat dotfiles-dir "themes"))
(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

;; Install themes
;; (package-require 'zenburn-theme)
(package-require 'anti-zenburn-theme)

;; Prepare colour themes
(require 'term)

(defun theme-light ()
  (interactive)
  (load-theme 'anti-zenburn)
  (zenburn-with-color-variables
   (custom-theme-set-faces
    'anti-zenburn

    `(mode-line
      ((,class (:foreground ,zenburn-green+1
                            :background ,zenburn-bg-1
                            :box (:line-width -1 :style released-button)))
       (t :inverse-video t)))
    `(mode-line-buffer-id ((t (:foreground ,zenburn-yellow :weight bold))))
    `(mode-line-inactive
      ((t (:foreground ,zenburn-green-1
                       :background ,zenburn-bg-05
                       :box (:line-width -1 :style released-button)))))))
  (set-face-background 'default "#ffffff")
  (set-face-foreground 'default "#000000")
  (set-face-background 'region "#d4d4d4")
  (set-face-foreground 'region nil)
  (set-face-background 'linum "#f0f0f0")
  (set-face-background 'fringe "#f0f0f0")

  (set-face-foreground 'term-color-black "#ffffff")
  (set-face-foreground 'term-color-red "#f5666d")
  (set-face-foreground 'term-color-green "#3cb64a")
  (set-face-foreground 'term-color-yellow "#ce5c00")
  (set-face-foreground 'term-color-blue "#00578e")
  (set-face-foreground 'term-color-magenta "#d020f0")
  (set-face-foreground 'term-color-cyan "#6799cc")
  (set-face-foreground 'term-color-white "#000000"))

(defun theme-dark ()
  (interactive)
  ;; (load-theme 'bubbleberry t)
  ;; (load-theme 'zenburn t)
  (load-theme 'bclues t)
  ;; (set-face-background 'default "#222")
  ;; (set-face-background 'region "#374186")
  ;; (set-face-background 'fringe "#191919")
  ;; (set-face-background 'hl-line "#191919")
  ;; (set-face-background 'linum nil)
  ;; (set-face-foreground 'linum "#acacfc")

  (set-face-foreground 'term-color-black "#3f3f3f")
  (set-face-foreground 'term-color-red "#cc9393")
  (set-face-foreground 'term-color-green "#7f9f7f")
  (set-face-foreground 'term-color-yellow "#f0dfaf")
  (set-face-foreground 'term-color-blue "#8cd0d3")
  (set-face-foreground 'term-color-magenta "#dc8cc3")
  (set-face-foreground 'term-color-cyan "#93e0e3")
  (set-face-foreground 'term-color-white "#dcdccc"))

(theme-dark)

(set-frame-font "Envy Code R 12")

;; Unclutter the modeline
(package-require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "ethan-wspace" '(diminish 'ethan-wspace-mode))
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
(eval-after-load "rainbow-mode" '(diminish 'rainbow-mode))
(eval-after-load "paredit" '(diminish 'paredit-mode))
;(eval-after-load "autopair" '(diminish 'autopair-mode))
(eval-after-load "abbrev" '(diminish 'abbrev-mode))
(eval-after-load "auto-complete" '(diminish 'auto-complete-mode))
(eval-after-load "js2-highlight-vars" '(diminish 'js2-highlight-vars-mode))
(eval-after-load "projectile" '(diminish 'projectile-mode))
(eval-after-load "mmm-mode" '(diminish 'mmm-mode))
(eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
(eval-after-load "skewer-mode" '(diminish 'skewer-mode))
(eval-after-load "auto-indent-mode" '(diminish 'auto-indent-minor-mode))
(eval-after-load "highlight-parentheses" '(diminish 'highlight-parentheses-mode))
(eval-after-load "subword" '(diminish 'subword-mode))
(eval-after-load "anzu" '(diminish 'anzu-mode))
(eval-after-load "cider" '(diminish 'cider-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "git-gutter" '(diminish 'git-gutter-mode))

(eval-after-load "js2-mode"
  '(defadvice js2-mode (after js2-rename-modeline activate)
     (setq mode-name "JS+")))
(eval-after-load "clojure-mode"
  '(defadvice clojure-mode (after clj-rename-modeline activate)
     (setq mode-name "Clj")))
(eval-after-load "typescript"
  '(defadvice typescript-mode (after typescript-rename-modeline activate)
     (setq mode-name "TS")))
(eval-after-load "nxhtml-mode"
  '(defadvice nxhtml-mode (after nxhtml-rename-modeline activate)
     (setq mode-name "HTML")))
(eval-after-load "js"
  '(defadvice js-mode (after js-rename-modeline activate)
     (setq mode-name "JS")))
(defadvice emacs-lisp-mode (after elisp-rename-modeline activate)
  (setq mode-name "ELisp"))

(provide 'theme)

