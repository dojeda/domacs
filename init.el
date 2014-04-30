(message "Initializing emacs")

(when (version< emacs-version "24.1")
  (error "Prelude requires at least GNU Emacs 24.1"))

;; Load package management 
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Required packages TODO: maybe put this in another file
(defvar domacs/required-packages
  '(zenburn-theme
    magit
    yasnippet)
  "A list of packages installed at launch")

(require 'cl)

;; function that checks if all packages are installed
(defun packages-installed-p ()
  (loop for p in domacs/required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; function that installs missing packages
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message " done.")
  ; install the missing packages
  (dolist (p domacs/required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; Load modules
(defvar domacs/base-dir (file-name-directory load-file-name)
  "The base directory of domacs (e.g. ~/.emacs.d)")
(defvar domacs/modules-dir (expand-file-name "modules" domacs/base-dir))
(add-to-list 'load-path domacs/modules-dir)

;; Load user interface settings TODO: put in another file
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(menu-bar-mode +1)

;; no blinking cursor
(blink-cursor-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; color theme
(load-theme 'zenburn)

;; Load OSX stuff
;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'osx-tweaks))

;; Some key configuration: TODO: put in another file
(require 'windmove)
(windmove-default-keybindings)

(message "Emacs is ready!")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cd70962b469931807533f5ab78293e901253f5eeb133a46c2965359f23bfb2ea" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
