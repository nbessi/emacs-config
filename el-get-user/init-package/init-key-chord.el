 (require 'key-chord)

(key-chord-define-global "cd" 'ace-jump-word-mode)
(key-chord-define-global "fg" 'er/expand-region)
(key-chord-define-global "df" 'ido-switch-buffer)
(key-chord-define-global "kl" 'switch-window)
(defun ins-par()
         (interactive)
         (insert "{}")
         (backward-char))

(key-chord-define-global "{{" 'ins-par)
