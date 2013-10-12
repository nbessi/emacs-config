;;---- kill compilation process ------------------
(defun kill_running_compilation()
  (interactive)
  (kill-buffer "*compilation*")

;;----- custom - convertion -------------------------
(defun switch-price(start end)
  "convert from without taxe to tax included"
  (interactive "r")
  (setq myStr (buffer-substring start end))
  (message "input %s" myStr)
  (setq res (* (/ (string-to-number myStr) 100) 108))
  (message "res %f" res)
  (delete-region start end)
  (insert  (format "%.2f" res)))

;;------ Helper for OpenERP code ---------------------
(defun erp_string_to_class(start end)
  (interactive "r")
  (setq myStr (buffer-substring start end))
  (message "input %s" myStr)
  (setq res(mapconcat 'capitalize (split-string myStr "\\.") ""))
  (delete-region start end)
  (insert res))

;;------ set transparancy ------
(defun set_frame_opacity(numb)
  "Set level of transparenbcy for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
        (message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb)))))

