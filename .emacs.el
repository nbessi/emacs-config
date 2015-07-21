(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(evil-search-module (quote evil-search))
 '(frame-background-mode (quote dark))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(nxml-slash-auto-complete-flag t)
 '(py-imenu-create-index-p t)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))) t)
 '(diff-removed ((t (:foreground "Red"))) t))

;;----------- scratch comment --------------------------------------------------
(setq initial-scratch-message "Useful Emacs commands I use less frequently:
Register: http://www.gnu.org/software/emacs/manual/html_node/emacs/Registers.html#Registers
Do not forget to use the extention list register.

The mark ring that works like the kill ring:
https://www.gnu.org/software/emacs/manual/html_node/emacs/Mark-Ring.html

The hide show minor mode:
http://www.gnu.org/software/emacs/manual/html_node/emacs/Hideshow.html

The emet mode to edit XML

The wgrep mode

The flush-line command

")

;;--------- disable menu -------------------------------------------------------
(menu-bar-mode -1)

;;--------- no background on emacsclient----------
(defun term_no_bg ()
  (interactive)
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

;;(add-hook 'window-setup-hook 'on-after-init-no-bg)
;;--------- package management -------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
;;---------Managing my package --------------------------------------------------
(require 'cl)
(defvar required-packages
  '(
    ace-jump-mode
    anaconda-mode
    clojure-mode
    company
    company-anaconda
    dash
    emmet-mode
    evil
    evil-leader
    expand-region
    feature-mode
    highlight-indentation
    magit
    multi-term
    multiple-cursors
    simp
    smex
    switch-window
    yaml-mode
    yasnippet
    )
  "a list of packages to ensure are installed at launch.")

; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
                                        ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;------- tab management -------------------------------------------------------
(setq-default indent-tabs-mode nil)

;;------- general setups -------------------------------------------------------
(global-set-key (kbd "C-z") 'undo)
(defalias 'yes-or-no-p 'y-or-n-p)
;; mac os keyboard
(setq mac-option-modifier nil)
(setq mac-option-key-is-meta nil)
;; paren mode active
(show-paren-mode 1)
;; custom shortcut
(global-set-key (kbd "§") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f6>") 'rgrep)
(global-set-key (kbd "<f7>") 'ido-switch-buffer)
(add-hook 'before-save-hook 'whitespace-cleanup)
;; enable cua mode
(cua-mode 1)

;;---- set font ----------------------------------------------------------------
;; (add-to-list 'default-frame-alist '(font . "Source Code Pro for Powerline-10"))

;;  (set-face-attribute 'default t
;;                      :font "Source Code Pro for Powerline-10")

;;--------------- line/columns numbers -----------------------------------------
(line-number-mode 1)
(column-number-mode 1)

;;------ comint mode lenght ----------------------------------------------------
(add-hook 'compilation-filter-hook 'comint-truncate-buffer)
(setq comint-buffer-maximum-size 200)

;;---- uniquify ----------------------------------------------------------------
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;;------ autosave --------------------------------------------------------------
;; Write backup files to defined directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)


;;----- disable splach screen --------------------------------------------------
(setq inhibit-splash-screen t)

;;------------- disable toolbar ------------------------------------------------
(condition-case nil
(tool-bar-mode -1)
(error nil))
(condition-case nil
(scroll-bar-mode -1)
(error nil))

;;------- Gui dialog box disable -----------------
(setq use-dialog-box nil)

;;---------- cursor-type -------------------------
(setq-default cursor-type 'bar)

;;----- recent-file ------------------------------
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;----- custom helpers ---------------------------
(load "~/.emacs.d/helper/helper")

;;------ set transparancy ------------------------
(defun set_frame_opacity(numb)
  "Set level of transparenbcy for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
        (message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

;;--- disable yas in term mode -------------------
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))
;;--- evil setup /install with elg-get even with melpa type seems broken ---
(require 'evil)
(evil-mode 1)
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

;;------ copy-paste in tmux ----------------------

(setq x-select-enable-clipboard t)
;;---- load package config -------
(add-to-list 'load-path "~/.emacs.d/package-configurations/")
;;---- server-mode at start up ---
(server-start)
