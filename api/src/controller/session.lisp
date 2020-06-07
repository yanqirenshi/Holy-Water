(in-package :holy-water.api.controller)

(defun get-session-data (angel)
  (list :|angel|     (dao2angel angel)
        :|maledicts| (hw.api.ctrl:find-maledicts angel)
        :|orthodox|  (hw.api.ctrl:angel-orthodox angel)
        :|orthodoxs| (hw.api.ctrl:find-orthodoxs)
        :|deamons|   (hw.api.ctrl:find-deamons-alive)
        :|external_service| nil
        :|wall_paper| :null
        :|impures|    (list :|purging| (hw.api.ctrl:get-impure-purging angel))))
