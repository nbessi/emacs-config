(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-mode 1)
;;---------------- evil leader setting -------------
(evil-leader/set-leader ",")
(evil-leader/set-key
  "j" 'avy-goto-char
  "b" 'ido-switch-buffer)
;;---------------- set evil default mode -----------
(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . emacs)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (help-mode . emacs)
                              (helm-grep-mode . emacs)
                              (grep-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (dired-mode . emacs)
                              (wdired-mode . emacs))
      do (evil-set-initial-state mode state))
;;------ underscore is not a word separator ------
(defadvice evil-inner-word (around underscore-as-word activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))
;;------ switch to normal mode on save -----------
(add-hook 'before-save-hook 'evil-normal-state)
