(require 'simp)
(simp-project-define
  '(:has (Odoo_makefile)
    :ignore (.git)))

;;--- Run an OpenERP instance using shell script -------------
(defun erp_launch()
  (interactive)
  ;; we pass in comint mode
  (message "Running: %s" (concat
                          (simp-project-root)
                          "/Odoo_makefile"))
  (shell-command (concat
                  "/usr/bin/make -f "
                  (simp-project-root)
                  "/Odoo_makefile")))
(global-set-key (kbd "<f9>") 'erp_launch)
;;------- sample function --------------------------------------
(require 'ansi-color)


;; (defun launch_project()
;;   (interactive)
;;   (let (session_name)
;;     (setq session_name "project_openerp_run")
;;     (shell-command (concat "tmux kill-session -t " session_name))
;;     (shell-command (concat "tmux new-session -d -s " session_name))
;;     (shell-command (concat "tmux send-keys -t " session_name":0.0 'python /home/nbessi/Bureau/test.py' enter"))
;;     (multi-term-dedicated-close)
;;     (multi-term-dedicated-open)
;;     (multi-term-dedicated-select)
;;     (process-send-string nil (concat "tmux -u -l attach -t " session_name))
;;     (term-send-input)
;;     ))

;; (launch_project)


;;-------------- Gives git unique revision info for each folder ------------
(defun erp_revision_info()
  (interactive)
  (message "Checking source: %s" (concat (simp-project-root) " "))
  (compile (concat "cd "
                   (concat (simp-project-root) "/parts ")
                   "&& for i in *;
                     do
                       cd $i
                       echo $i = $(git rev-parse HEAD)
                       cd ..
                     done "
                   "&& "
                   "cd "
                   (concat (simp-project-root) "/Scenario ")
                   "&& for i in *;
                      do
                       cd $i
                       echo $i = $(git rev-parse HEAD)
                       cd ..
                   done")))


;;------------ Run commands in OpenERP.meta folder
(defun erp_get_avail_commands()
  (directory-files (concat (simp-project-root) "/OpenERP.meta/")))

(defun erp_run_command (arg)
  (interactive
   (list
    (completing-read "Choose one: " (erp_get_avail_commands))))
  (compile  (concat (simp-project-root) "/OpenERP.meta/" arg))
  (notify "OpenERP script" (concat (simp-project-root) "/OpenERP.meta/" arg)))
