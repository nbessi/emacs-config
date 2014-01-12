(autoload 'jedi:setup "jedi" nil t)
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:server-command
          (list "/usr/bin/python2.7" jedi:server-script))
(setq jedi:server-args
                '("--sys-path" "/oe/openerp_trunk_community/parts/server/"
                  "--sys-path" "/oe/openerp_trunk_community/parts/server/openerp/"
                  "--sys-path" "/oe/openerp_trunk_community/parts/server/addons/"
                  "--sys-path" "/oe/openerp_trunk_community/parts/addons/"))
