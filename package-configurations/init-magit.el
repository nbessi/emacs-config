(require 'magit)
(add-to-list 'load-path "~/.emacs.d/git-modes")
(add-to-list 'load-path "~/.emacs.d/magit")
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "/~/.emacs.d/magit/")))
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")
