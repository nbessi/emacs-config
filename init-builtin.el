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
;;------- linum-mode by default ------------------------------------------------
(global-linum-mode 1)
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
;;---------------Set font-------------------------------
(if (eq system-type 'gnu/linux)
    (progn
      (add-to-list 'default-frame-alist '(font . "Hack-11"))

      (set-face-attribute 'default t :font "Hack-11"))
)
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

;;------ copy-paste in tmux ----------------------

(setq x-select-enable-clipboard t)

;;------ org Babel -------------------------------

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (java . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))
;;----org LATEX------------------------------------

(require 'ox-latex)
(add-to-list 'org-latex-classes
          '("doc_vaud"
          "\\documentclass[french,fleqn,10pt,hidelinks]{article}
           \\usepackage[a4paper,left=25mm,right=25mm,top=20mm,bottom=30mm]{geometry}
           \\usepackage[utf8]{inputenc}
           \\usepackage{titling}
           \\usepackage{babel}
           \\usepackage[dvipsnames]{xcolor}
           \\usepackage{graphicx}
           \\usepackage{wrapfig}
           \\usepackage{color}
           \\usepackage{titling} %make title hook
           \\usepackage{titlesec}
           \\usepackage{tikz}\\usetikzlibrary{shapes.misc}
           \\usepackage{fancyhdr}
           % Remove paragrph indent
           \\setlength{\\parindent}{0cm}
           %
           \\pagestyle{fancy}
           % redefine title
           % Headers
           \\lhead{\\includegraphics[width=20px]{./logo.png}}%
           \\chead{\\DSI Pôle \TEP - NBI - {\\today}}

           % Footers
           \\lfoot{{\\scriptsize Direction des systèmes d'information – DSI \\newline Avenue de Longemalle 1, CH-1020 Lausanne \\newline www.vd.ch – T 41 21 316 26 00 – F 41 21 316 27 26}}%
           \\rhead{\\thepage}%
           \\cfoot{}%
           \\rfoot{}%
           \\renewcommand{\\headrulewidth}{0.4pt}
           \\renewcommand{\\footrulewidth}{0.4pt}
          % Section style
          \\newcommand\\titlebar{%
          \\tikz[baseline,trim left=3.1cm,trim right=3cm] {
          \\fill [ForestGreen!60!White] (2.5cm,-1ex) rectangle (\\textwidth+3.1cm,2.5ex);
          \\node [fill=ForestGreen,
            anchor= base east,
            rounded rectangle,
            minimum height=3.5ex] at (3cm,0) {
          \\textbf{\\thesection.0}
                 };
             }%
          }
         \\titleformat{\\section}{\\large}{\\titlebar}{0.1cm}{}
         %\\renewcommand*{\\thesection}{\\arabic{section}}
         % calling maketitle hook
         \\postdate{\\par \\par \\par \\newline \\includegraphics{./logo.png}
         \\vspace*{\\fill}
                    \\par \\par Classification : Interne DSI \\par Destinataires : Collaborateurs DSI
                    \\pagebreak}
         % set \texttt background for org ~xxx~ style
         \\let\\OldTexttt\\texttt
         \\renewcommand{\\texttt}[1]{\\OldTexttt{\\hl{#1}}}
         "

          ("\\section{%s}" . "\\section*{%s}")
          ("\\subsection{%s}" . "\\subsection*{%s}")
          ("\\subsubsection{%s}" . "\\sbsubsection*{%s}")
          ("\\paragraph{%s}" . "\\paragraph*{%s}")
          ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
