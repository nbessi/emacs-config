(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(evil-search-module (quote evil-search))
 '(frame-background-mode (quote dark))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(nxml-slash-auto-complete-flag t)
 '(py-imenu-create-index-p t)
 '(safe-local-variable-values (quote ((eval when (fboundp (quote rainbow-mode)) (rainbow-mode 1)) (encoding . utf-8))))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))) t)
 '(diff-removed ((t (:foreground "Red"))) t))

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
    dash
    f
    avy
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
    flycheck
    highlight-indentation
;;    magit
    multi-term
    multiple-cursors
    simp
    smex
    switch-window
    yaml-mode
    solarized-theme
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
;;------- loading packages setup -----------------------------------------------

(load "~/.emacs.d/package-configurations/init-anaconda-mode.el")
(load "~/.emacs.d/package-configurations/init-color-theme.el")
(load "~/.emacs.d/package-configurations/init-company-anaconda.el")
(load "~/.emacs.d/package-configurations/init-company.el")
(load "~/.emacs.d/package-configurations/init-evil.el")
(load "~/.emacs.d/package-configurations/init-expand-region.el")
(load "~/.emacs.d/package-configurations/init-feature-mode.el")
(load "~/.emacs.d/package-configurations/init-flycheck.el")
(load "~/.emacs.d/package-configurations/init-ido.el")
(load "~/.emacs.d/package-configurations/init-multiple-cursors.el")
(load "~/.emacs.d/package-configurations/init-python.el")
(load "~/.emacs.d/package-configurations/init-ruby.el")
(load "~/.emacs.d/package-configurations/init-simp.el")
(load "~/.emacs.d/package-configurations/init-smex.el")
(load "~/.emacs.d/package-configurations/init-switch-window.el")
(load "~/.emacs.d/package-configurations/init-yaml-mode.el")
(load "~/.emacs.d/package-configurations/init-yasnippet.el")

;;----- load builtin config ----------------------------------
(load "~/.emacs.d/init-builtin.el")

;;---- server-mode at start up ---
(server-start)
