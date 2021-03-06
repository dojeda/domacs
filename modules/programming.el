;; programming-related configuration

;; Smart parens
(require 'smartparens)
(show-smartparens-global-mode t)
(add-hook 'prog-mode-hook 'turn-on-smartparens-mode)

;; Indentation
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; 
(setq compilation-scroll-output t)    ;; the compilation output should scroll down automatically

;; In Mensia, Indentation rules are different, let's create a class
;; for these directories (instead of using .dir-locals.el)
(dir-locals-set-class-variables 'mensia-style-dir
                                '((nil . ((indent-tabs-mode . t)
                                          (fill-column . 120)))))
(defvar mensia-directories
  '("~/devel/neurort/" "~/devel/certivibe"))

(defun configure-mensia-directories (list)
  "Configure all mensia directories to follow the same dir-locals configuration"
  (when list
    (progn
      (message (format "Configuring mensia dir-locals class in directory %s" (car list)))
      (dir-locals-set-directory-class (car list) 'mensia-style-dir)
      )
    (configure-mensia-directories (cdr list))))
;; (dir-locals-set-directory-class
;;  "/home/david/devel/openvibe/" 'mensia-style-dir)
;; (dir-locals-set-directory-class
;;  "/home/david/devel/openvibe/external/mensia/" 'mensia-style-dir)
(configure-mensia-directories mensia-directories)

;; test: C/C++ headers have a dedicated mode so that purpose-mode puts those buffers in a dedicated window
(define-derived-mode c-header-mode
  c++-mode
  "Header"
  "A test of a C/C++ header mode")

;; auto-complete configuration
(require 'auto-complete)
(require 'auto-complete-config) ;; default config for auto-complete
(require 'auto-complete-clang)  ;; auto-complete + clang
;;(ac-config-default)
(setq ac-auto-start nil) ;; start completion after N characters, here I disable it (if I want to complete, I call auto-complete)
(setq ac-quick-help-delay 1.5) ;; delay for quick help, in seconds (quick help shows more info about the var/method)
(setq ac-comphist-file (expand-file-name  "ac-comphist.dat" domacs/savefile-dir))

;; Configure the auto-complete packages
;; TODO: this needs to be reconsidered when using linux, the hard-coded paths here are for OSX
(defun domacs/ac-config ()
  (message "Running domacs auto-complete config")
  (setq ac-clang-flags
        (mapcar (lambda (item)(concat "-I" item))
                                        (split-string
                                         "
  /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1
  /usr/local/include
  /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/5.1/include
  /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
  /usr/include
  /usr/local/include
"
                                         )))
  ;; the following lines are verbatim from auto-complete-config (the default configuration ac-config-default)
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t)
  ;; add a key for completion
  (define-key ac-mode-map [(meta return)] 'ac-complete-clang)
  )
(defun domacs/ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
  ;;(setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'domacs/ac-config)
(add-hook 'c-mode-common-hook 'domacs/ac-cc-mode-setup)
(add-hook 'c-mode-common-hook
      (lambda ()
       (font-lock-add-keywords nil
        '(("\\<\\(true\\|false\\)\\>" .
           font-lock-keyword-face)))))

;; semantic
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
(require 'semantic/ia)
(semantic-mode 1)
(require 'stickyfunc-enhance)

;; use semantic as backend of auto-complete
(defun domacs/add-semantic-to-auto-complete ()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'domacs/add-semantic-to-auto-complete)

;; snippets
(require 'yasnippet)
(yas-global-mode 1)

;; ;; cpputils
;; ;; (add-to-list 'load-path "~/apps/cpputils-cmake" )
;; (require 'cpputils-cmake)
;; ;;(setq cppcm-debug t)
;; (defun domacs/cppcm-hook ()
;;   (message "cppcm-hook of %s" buffer-file-name)
;;   (cppcm-reload-all)
;;   ;; call semantic-add-system-include for all items in cppcm-include-dirs
;;   (dolist (myvar cppcm-include-dirs)
;;     (semantic-add-system-include (replace-regexp-in-string "-I" "" myvar))))
;; ;; (add-hook 'c-mode-common-hook
;; ;;           (lambda ()
;; ;;             (if (derived-mode-p 'c-mode 'c++-mode)
;; ;;                 (if  (not (or (string-match "^/usr/local/include/.*" buffer-file-name)
;; ;;                               (string-match "^/usr/src/linux/include/.*" buffer-file-name)
;; ;;                               (string-match "^/usr/local/Cellar/.*" buffer-file-name)))
;; ;;                     (domacs/cppcm-hook)
;; ;;                   ))))
;; ;;(add-hook 'c-mode-hook (lambda () (cppcm-reload-all)))
;; ;;(add-hook 'c++-mode-hook (lambda () (cppcm-reload-all)))

;; A function to switch easily between C/C++ source and its header
(defvar c++-default-header-ext "h")
(defvar c++-default-source-ext "cpp")
(defvar c++-header-ext-regexp "\\.\\(hpp\\|hxx\\|h\\|\hh\\|H\\)$")
(defvar c++-source-ext-regexp "\\.\\(cpp\\|cxx\\|c\\|\cc\\|C\\)$")
(defvar c++-source-extension-list '("c" "cc" "C" "cpp" "cxx" "c++"))
(defvar c++-header-extension-list '("h" "hh" "H" "hpp" "hxx"))
;;(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-header-mode))

(defun toggle-source-header()
  "Switches to the source buffer if currently in the header buffer and vice versa."
  (interactive)
  (let ((buf (current-buffer))
        (name (file-name-nondirectory (buffer-file-name)))
        file
        offs)
    (setq offs (string-match c++-header-ext-regexp name))
    (if offs
        (let ((lst c++-source-extension-list)
              (ok nil)
              ext)
          (setq file (substring name 0 offs))
          (while (and lst (not ok))
            (setq ext (car lst))
            (if (file-exists-p (concat file "." ext))
                  (setq ok t))
            (setq lst (cdr lst)))
          (if ok
              (find-file (concat file "." ext))))
      (let ()
        (setq offs (string-match c++-source-ext-regexp name))
        (if offs
            (let ((lst c++-header-extension-list)
                  (ok nil)
                  ext)
              (setq file (substring name 0 offs))
              (while (and lst (not ok))
                (setq ext (car lst))
                (if (file-exists-p (concat file "." ext))
                    (setq ok t))
                (setq lst (cdr lst)))
              (if ok
                  (find-file (concat file "." ext)))))))))
;; (global-set-key [f9] 'toggle-source-header)

;; a function to be used with semantic to jump and pop from tags
(defvar domacs/semantic-tags-location-ring (make-ring 20))

(defun domacs/semantic-goto-definition (point)
  "Goto definition using semantic-ia-fast-jump
save the pointer marker if tag is found"
  (interactive "d")
  (condition-case err
      (progn
        (ring-insert domacs/semantic-tags-location-ring (point-marker))
        (semantic-ia-fast-jump point)
        (recenter))
    (error
     ;;if not found remove the tag saved in the ring
     (set-marker (ring-remove domacs/semantic-tags-location-ring 0) nil nil)
     (signal (car err) (cdr err)))))

(defun domacs/semantic-pop-tag-mark ()
  "popup the tag save by semantic-goto-definition"
  (interactive)
  (if (ring-empty-p domacs/semantic-tags-location-ring)
      (message "%s" "No more tags available")
    (let* ((marker (ring-remove domacs/semantic-tags-location-ring 0))
              (buff (marker-buffer marker))
                 (pos (marker-position marker)))
      (if (not buff)
            (message "Buffer has been deleted")
        (switch-to-buffer buff)
        (goto-char pos)
        (recenter))
      (set-marker marker nil nil))))

;; cmake
(require 'cmake-mode)
(setq auto-mode-alist
     (append
      '(("CMakeLists\\.txt\\'" . cmake-mode))
      '(("\\.cmake\\'" . cmake-mode))
      auto-mode-alist))

;; ack
;; (require 'ack-and-a-half)
;; (defalias 'ack 'ack-and-a-half)
;; (defalias 'ack-same 'ack-and-a-half-same)
;; (defalias 'ack-find-file 'ack-and-a-half-find-file)
;; (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "--simple-prompt"
      elpy-rpc-python-command "python3")

;; old python (jedi)
;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args "--pylab"
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
;;(require 'jedi)
;;(jedi:install-server)


;; (require 'jedi-direx)
;; (eval-after-load "python"
;;   '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
;; (add-hook 'jedi-mode-hook 'jedi-direx:setup)

;; PDB command line
(defun dojeda/pdb ()
  "Run python debugger on current buffer."
  (interactive)
  (setq command (format "python3 -u -m pdb %s " (file-name-nondirectory buffer-file-name)))
  (let ((command-with-args (read-string "Debug command: " command nil nil nil)))
    (pdb command-with-args)))

;; python + purpose mode
;;(require 'window-purpose)

;; ;; R + ESS
;; (message "Loading ESS")
;; (require 'ess-site)
;; (ess-toggle-underscore nil) ;; leave underscore key alone!
;; (message "Finished loading ESS")

;;rtags
(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)
(setq rtags-use-helm t)

;; HOOKS
(defun domacs/c-hook ()
  (setq c-basic-offset 4) ;; ?
  (local-set-key [f5] 'goto-line)           ;; F5 is go to line
  (local-set-key [f9] 'toggle-source-header) ;; F9 changes source/header
  (local-set-key (kbd "C-c C-c") 'compile)
  (local-set-key (kbd "s-<up>") 'domacs/semantic-pop-tag-mark)      ;; super-up pops tag
  (local-set-key (kbd "s-<down>") 'domacs/semantic-goto-definition) ;; super-down goes to tag definition
  (flycheck-mode 1)
  (subword-mode 1) ;; move in CamelCase words
  (whitespace-mode 1))
(defun domacs/c++-hook ()
  (setq flycheck-clang-language-standard "c++14"))
(add-hook 'c-mode-hook 'domacs/c-hook)
(add-hook 'c++-mode-hook 'domacs/c-hook)
(add-hook 'c++-mode-hook 'domacs/c++-hook)

;; Python
(require 'elpy)
(define-key elpy-mode-map (kbd "<C-down>") nil) ;; disable elpy's backward block
(define-key elpy-mode-map (kbd "<C-up>") nil)   ;; disable elpy's forward block
(define-key elpy-mode-map (kbd "<M-down>") nil) ;; disable elpy's move region or line
(define-key elpy-mode-map (kbd "<M-up>") nil)   ;; disable elpy's move region or line
(define-key elpy-mode-map (kbd "<M-left>") nil) ;; disable elpy's move indent left
(define-key elpy-mode-map (kbd "<M-right>") nil)   ;; disable elpy's move indent right
(elpy-enable)

;; pylint
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)


(defun domacs/send-python-file ()
  (interactive)
  (python-shell-send-file (buffer-file-name) '())
  )
(defun domacs/python-send-line ()
  (interactive)
  (python-shell-send-region (point-at-bol) (point-at-eol)))
(defun domacs/python-hook ()
  (local-set-key [f5] 'goto-line)           ;; F5 is go to line
  (local-set-key (kbd "C-c C-<return>") 'domacs/send-python-file)
  ;;(local-set-key (kbd "C-<tab>") 'jedi:complete)
  (local-set-key (kbd "C-<tab>") 'elpy-company-backend)
  (local-set-key (kbd "C-<return>") 'domacs/python-send-line)
  (local-set-key (kbd "s-<up>") 'pop-tag-mark)
  (local-set-key (kbd "s-<down>") 'elpy-goto-definition)
  (subword-mode 1) ;; move in CamelCase words
  (whitespace-mode 1)
  ;;(semantic-idle-summary-mode nil)
  )
(add-hook 'python-mode-hook 'domacs/python-hook)

;; Latex
(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)

;; common hook for all programming modes
(defun domacs/programming-hook ()
  (set-face-attribute 'header-line nil  :height 110)
  (setq-default fill-column 80)
  (fci-mode 1) ;; does not play well with company-mode, but a defadvice might fix it
  (git-gutter-mode 1)
  )
(add-hook 'prog-mode-hook 'domacs/programming-hook)

;; misc
(add-to-list 'auto-mode-alist '("\\.rc\\'" . conf-mode))

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(defun domacs/yaml-hook ()
  (define-key yaml-mode-map "\M-q" 'yaml-fill-paragraph))
(add-hook 'yaml-mode-hook 'domacs/yaml-hook)


(provide 'programming)
