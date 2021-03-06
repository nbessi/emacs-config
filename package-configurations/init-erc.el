(require 'erc)
(add-to-list 'erc-modules 'notifications)
(add-to-list 'erc-modules 'notify)
(add-to-list 'erc-modules 'spelling)
(add-to-list 'erc-modules 'smiley)
(setq erc-autoaway-idle-seconds 600)
(setq erc-log-channels-directory "~/.erc/logs/")

(defun geek-node-irc (pws)
  (interactive "sPassword: ")
  (erc :server "irc.geeknode.org" :port 6667 :nick "nbessi")
  (sleep-for 2)
  (erc-send-message (concat " C nick identify " pws))
  (sleep-for 2)
  (erc-server-send "join #c2c-business"))
