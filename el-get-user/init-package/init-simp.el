(require 'simp)
(simp-project-define
  '(:has (OpenERP.meta)
    :ignore (.bzr)))

;;--- Run an OpenERP instance using shell script -------------
(defun erp_launch()
  (interactive)
  ;; we pass in comint mode
  (defadvice compile
    (before ad-compile-smart activate)
    (ad-set-arg 1 t))
  (ansi-color-for-comint-mode-on)
  (message "Running: %s" (concat
                          (simp-project-root)
                          "/OpenERP.meta/launch.sh"))
  (compile
   (concat
    (simp-project-root) "/OpenERP.meta/launch.sh")))
(global-set-key (kbd "<f9>") 'erp_launch)
;;(global-set-key (kbd "A-b") 'erp_launch)

;;-------------- Show bzr status of all branches of OpenERP ------------
(defun erp_sources_status()
  (interactive)
  (message "Checking source: %s" (concat (simp-project-root) "/parts"))
  (compile (concat "cd "
                   (concat (simp-project-root) "/parts")
                   "&& for i in *; do echo ------$i------; bzr status  $i ;done")))


;;------------ Run commands in OpenERP.meta folder
(defun erp_get_avail_commands()
  (directory-files (concat (simp-project-root) "/OpenERP.meta/")))

(defun erp_run_command (arg)
  (interactive
   (list
    (completing-read "Choose one: " (erp_get_avail_commands))))
  (compile  (concat (simp-project-root) "/OpenERP.meta/" arg))
  (notify "OpenERP script" (concat (simp-project-root) "/OpenERP.meta/" arg)))
