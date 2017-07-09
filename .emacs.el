(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "003a9aa9e4acb50001a006cfde61a6c3012d373c4763b48ceb9d523ceba66829" "2b8dff32b9018d88e24044eb60d8f3829bd6bbeab754e70799b78593af1c3aba" "158013ec40a6e2844dbda340dbabda6e179a53e0aea04a4d383d69c329fba6e6" "b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(evil-search-module (quote evil-search))
 '(frame-background-mode (quote dark))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(nxml-slash-auto-complete-flag t)
 '(package-selected-packages
   (quote
    (powerline-evil yasnippet yaml-mode switch-window smex simp ox-pandoc multiple-cursors multi-term magit highlight-indentation flycheck feature-mode expand-region evil-leader emmet-mode company-anaconda color-theme-solarized clojure-mode avy airline-themes)))
 '(py-imenu-create-index-p t)
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1))
     (encoding . utf-8))))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))))
 '(diff-removed ((t (:foreground "Red")))))

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
    magit
    multi-term
    multiple-cursors
    simp
    smex
    switch-window
    yaml-mode
    yasnippet
    color-theme-solarized
    powerline
    airline-themes
    org
    ox-pandoc
    ;;calfw
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
(load "~/.emacs.d/package-configurations/init-erc.el")
(load "~/.emacs.d/package-configurations/init-expand-region.el")
(load "~/.emacs.d/package-configurations/init-feature-mode.el")
;;(load "~/.emacs.d/package-configurations/init-flycheck.el")
(load "~/.emacs.d/package-configurations/init-ido.el")
(load "~/.emacs.d/package-configurations/init-magit.el")
(load "~/.emacs.d/package-configurations/init-multiple-cursors.el")
(load "~/.emacs.d/package-configurations/init-python.el")
(load "~/.emacs.d/package-configurations/init-ruby.el")
(load "~/.emacs.d/package-configurations/init-simp.el")
(load "~/.emacs.d/package-configurations/init-smex.el")
(load "~/.emacs.d/package-configurations/init-switch-window.el")
(load "~/.emacs.d/package-configurations/init-yaml-mode.el")
(load "~/.emacs.d/package-configurations/init-yasnippet.el")
;;(load "~/.emacs.d/package-configurations/init-calfw.el")
(load "~/.emacs.d/htmlize.el")
;;(load "~/.emacs.d/package-configurations/init-mu4e.el")

;;----- load builtin config ----------------------------------
(load "~/.emacs.d/init-builtin.el")

;;---- server-mode at start up ---
(server-start)
