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

(provide 'key-config)
