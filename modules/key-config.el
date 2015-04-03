;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; the old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; shift-arrow to move across buffers 
(require 'windmove)
(windmove-default-keybindings)

;; f7 to comment
(global-set-key [f7] 'comment-region)
(global-set-key (kbd "S-<f7>") 'uncomment-region)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Magit keys
(global-set-key (kbd "C-x g") 'magit-status)
;; git messenger
(global-set-key (kbd "C-x v p") 'git-messenger:popup-message)

;; IBuffer for easier buffer switching with C-x C-b
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Ace-jump mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'key-config)
