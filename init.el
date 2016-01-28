(message "Initializing emacs")

;; This configuration needs at least 24.1
(when (version< emacs-version "24.1")
  (error "Prelude requires at least GNU Emacs 24.1"))

;; Some common variables
(defvar domacs/base-dir (file-name-directory load-file-name)
  "The base directory of domacs (e.g. ~/.emacs.d)")
(defvar domacs/modules-dir (expand-file-name "modules" domacs/base-dir)
  "Directory where specific module files are stored")
(defvar domacs/personal-dir (expand-file-name "personal" domacs/base-dir)
  "Personal files and customizations directory")
(defvar domacs/savefile-dir (expand-file-name "savefile" domacs/base-dir)
  "Directory for automatic saves and history files.")
(defvar domacs/extras-dir (expand-file-name "extras" domacs/base-dir)
  "Directory for xxx.")

(unless (file-exists-p domacs/savefile-dir)
  (make-directory domacs/savefile-dir))

;; Configure where customizations are saved
(setq custom-file (expand-file-name "custom.el" domacs/personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p domacs/personal-dir)
  (message "Loading personal configuration files in %s..." domacs/personal-dir)
  (mapc 'load (directory-files domacs/personal-dir 't "^[^#].*el$")))

;; Setup path to load modules
(add-to-list 'load-path domacs/modules-dir)
(add-to-list 'load-path domacs/extras-dir)

;; Module 1: packages
(require 'base-packages)

;; Module 2: UI configuration
(require 'ui-config)
;;(require 'ocodo-slim-svg-mode-line)

;; Module 3: OSX specific settings
(when (eq system-type 'darwin)
  (require 'osx-tweaks))

;; Module 4: programming
(require 'programming)

;; Module 5: key configuration
(require 'key-config)


(message "Emacs is ready!")
