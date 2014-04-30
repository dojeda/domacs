;; OSX tweaks

(normal-erase-is-backspace-mode t)

(setq-default scroll-conservatively 1000) ;scroll 1 line at a time
(setq scroll-step 1)                      ;scroll 1 line at a time
(setq font-lock-maximum-decoration t)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [del] 'delete-char)

;; The hyper key (command) is meta
(setq ns-function-modifier 'hyper)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(message "Command is now bound to META and Option is bound to SUPER.")

(provide 'osx-tweaks)
