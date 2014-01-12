(add-hook 'python-mode-hook #'(lambda ()
            (setq flycheck-flake8-maximum-line-length 80)))
