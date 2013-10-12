(autoload 'jedi:setup "jedi" nil t)
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:server-command
          (list "/opt/python_env/2.7/bin/python" jedi:server-script))
(setq jedi:server-args
                '("--sys-path" "/opt/openerp_community/openerp_trunk_community/parts/server/"
                  "--sys-path" "/opt/openerp_community/openerp_trunk_community/parts/server/openerp/"
                  "--sys-path" "/opt/openerp_community/openerp_trunk_community/parts/server/addons/"
                  "--sys-path" "/opt/openerp_community/openerp_trunk_community/parts/addons/"))

