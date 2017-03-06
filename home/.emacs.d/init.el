(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;;(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings clojure-mode nrepl)
;;(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

(defvar my-packages '(clojure-mode nrepl)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'tango-dark t)

(menu-bar-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(show-paren-mode t)

;; put all backup files in a single location to avoid clutter
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq backup-by-copying t)
(setq inhibit-startup-message t)
(setq undo-limit 10000)

;; use shorter keystrokes for confirmation dialogues
(fset 'yes-or-no-p 'y-or-n-p)

;; enable eldoc in clojure buffers
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

;; paredit mode for clojure
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook '(lambda ()
				(local-set-key (kbd "RET") 'newline-and-indent)))
