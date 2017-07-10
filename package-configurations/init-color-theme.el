;;------custom color them --------
(require 'powerline)
(require 'moe-theme)
(moe-dark)
(moe-theme-set-color 'w/b)
(powerline-moe-theme)
(powerline-center-evil-theme)
(show-paren-mode t)
(setq show-paren-style 'expression)
(custom-theme-set-faces
 'moe-dark
  '(font-lock-string-face ((t (:foreground  "#268bd2")))))
