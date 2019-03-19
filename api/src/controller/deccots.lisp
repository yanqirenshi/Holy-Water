(in-package :holy-water.api.controller)


(defun find-deccots (angel)
  (flet ((get-class-name (deccot)
           (let ((symbol (class-name (class-of deccot))))
             (cond ((string= 'HOLY-WATER::RS_DECCOT-GITLAB symbol) "GITLAB")
                   (t    "????????")))))
    (mapcar #'(lambda (deccot)
                (list :|id|      (mito:object-id deccot)
                      :|service| (get-class-name deccot)))
            (hw:find-deccots angel))))
