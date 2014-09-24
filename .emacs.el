(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
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
 '(diff-removed ((t (:foreground "Red"))) t)
;; '(term-color-blue ((t (:background "sky blue" :foreground "light steel blue"))) t)
)


;;----------- scratch comment --------------------
(setq initial-scratch-message "Useful Emacs commands I use less frequently:
Register: http://www.gnu.org/software/emacs/manual/html_node/emacs/Registers.html#Registers
Do not forget to use the extention list register.

The mark ring that works like the kill ring:
https://www.gnu.org/software/emacs/manual/html_node/emacs/Mark-Ring.html

The hide show minor mode:
http://www.gnu.org/software/emacs/manual/html_node/emacs/Hideshow.html

The emmet mode to edit XML

In short:
The wgrep mode
the flush-line command

")




;;--------- disable menu -------------------------
(menu-bar-mode -1)

;;--------- no background on emacsclient----------
(defun term_no_bg ()
  (interactive)
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

;;(add-hook 'window-setup-hook 'on-after-init-no-bg)
;;--------- package-------------------------------
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

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
        (:name color-theme-solarized :type elpa)
        (:name anaconda-mode :type elpa)
        (:name company :type elpa)
        (:name company-anaconda :type elpa)
        (:name wgrep :type git
               :url "https://github.com/mhayashi1120/Emacs-wgrep.git")
        ))

(setq my-packages
      (append
       '(smex ace-jump-mode yasnippet switch-window expand-region
              multiple-cursors yaml-mode yasnippet anaconda-mode
              highlight-indentation company-mode company-anaconda wgrep ;;jedi
              feature-mode f clojure-mode dash)
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
                     :family "Source Code Pro for Powerline" :height 95 :weight 'normal)



;;--------------- line/columns numbers ----
(line-number-mode 1)
(column-number-mode 1)

;;------ comint mode lenght ----
(add-hook 'compilation-filter-hook 'comint-truncate-buffer)
(setq comint-buffer-maximum-size 200)

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

;;------ set transparancy ------------------------
(defun set_frame_opacity(numb)
  "Set level of transparenbcy for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
        (message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

;;---disable yas in term mode -------------------
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))

;;------copy-paste in tmux ----------------------

(setq x-select-enable-clipboard t)

;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
;; (unless window-system
;;  (when (getenv "DISPLAY")
;;   ;; Callback for when user cuts
;;   (defun xsel-cut-function (text &optional push)
;;     ;; Insert text to temp-buffer, and "send" content to xsel stdin
;;     (with-temp-buffer
;;       (insert text)
;;       ;; I prefer using the "clipboard" selection (the one the
;;       ;; typically is used by c-c/c-v) before the primary selection
;;       ;; (that uses mouse-select/middle-button-click)
;;       (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
;;   ;; Call back for when user pastes
;;   (defun xsel-paste-function()
;;     ;; Find out what is current selection by xsel. If it is different
;;     ;; from the top of the kill-ring (car kill-ring), then return
;;     ;; it. Else, nil is returned, so whatever is in the top of the
;;     ;; kill-ring will be used.
;;     (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
;;       (unless (string= (car kill-ring) xsel-output)
;;         xsel-output )))
;;   ;; Attach callbacks to hooks
;;   (setq interprogram-cut-function 'xsel-cut-function)
;;   (setq interprogram-paste-function 'xsel-paste-function)
;;   ;; Idea from
;;   ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
;;   ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
;;  ))

;;----server-mode---
(server-start)
