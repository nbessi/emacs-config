(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(nxml-slash-auto-complete-flag t)
 '(py-imenu-create-index-p t)
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))))
 '(diff-removed ((t (:foreground "Red"))))
 '(term-color-blue ((t (:background "sky blue" :foreground "light steel blue")))))

;;----------- scratch comment --------------------
(setq initial-scratch-message "Usefull emacs command I use less frequently:
Register: http://www.gnu.org/software/emacs/manual/html_node/emacs/Registers.html#Registers
Do not forget to use the extention list register.

The mark ring that works like the kill ring:
https://www.gnu.org/software/emacs/manual/html_node/emacs/Mark-Ring.html

The hide show minor mode:
http://www.gnu.org/software/emacs/manual/html_node/emacs/Hideshow.html

In short:
The wgrep mode
the flush-line command

")

;;--------- disable menu -------------------------
(menu-bar-mode -1)

;;--------- package-------------------------------
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;---------- el-get----------------------------------
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (let (el-get-install-skip-emacswiki-recipes)
        (goto-char (point-max))
        (eval-print-last-sexp)))))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(setq el-get-user-package-directory "~/.emacs.d/el-get-user/init-package")

(setq el-get-sources
      '((:name simp :type git
               :url "https://github.com/re5et/simp.git")
        (:name cider :type git
               :url "https://github.com/clojure-emacs/cider.git")
        (:name wgrep :type git
               :url "https://github.com/mhayashi1120/Emacs-wgrep.git")
        ))

(setq my-packages
      (append
       '(smex ace-jump-mode yasnippet switch-window expand-region
              multiple-cursors yaml-mode yasnippet
              highlight-indentation  auto-complete wgrep jedi
              feature-mode color-theme f clojure-mode dash)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)


(setq-default indent-tabs-mode nil)

;;------- general setups ------------------------------
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

;;---- set font -----
 (set-face-attribute 'default nil
                    :family "Menlo for Powerline" :height 95 :weight 'normal)

;;--------------- line/columns numbers ----
(line-number-mode 1)
(column-number-mode 1)

;;------ comint mode lenght ----
(add-hook 'compilation-filter-hook 'comint-truncate-buffer)
(setq comint-buffer-maximum-size 2000)

;;---- uniquify ----------------------------------------
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;;------ autosave --------------------------------------
;; Write backup files to own directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)


;;----- splach screen --------------------------
(setq inhibit-splash-screen t)

;;------------- disable toolbar ----------------
(condition-case nil
(tool-bar-mode -1)
(error nil))
(condition-case nil
(scroll-bar-mode -1)
(error nil))

;;------- gui dialog box disable -----------------
(setq use-dialog-box nil)

;;---------- cursor ------------------------------
(setq-default cursor-type 'bar)

;;----- recent-file ------------------------------
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;----- builtin config ---------------------------
(load "~/.emacs.d/init-builtin/ido")
(load "~/.emacs.d/init-builtin/python")
(load "~/.emacs.d/init-builtin/ruby")
;;----- custom helpers ---------------------------
(load "~/.emacs.d/helper/helper")

;;------ set transparancy ------
(defun set_frame_opacity(numb)
  "Set level of transparenbcy for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
        (message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

;;---disable yas in term mode ---
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))

;;----server-mode---
(server-start)
