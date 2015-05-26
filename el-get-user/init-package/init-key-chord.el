 (require 'key-chord)

(key-chord-define-global "fg" 'er/expand-region)
(key-chord-define-global "df" 'ido-switch-buffer)
(key-chord-define-global "jk" 'switch-window)
(key-chord-define-global "vv" 'ace-jump-mode)
(key-chord-define-global "ii" 'evil-normal-state)
(defun ins-par()
         (interactive)
         (insert "{}")
         (backward-char))

(key-chord-define-global "{{" 'ins-par)
