(in-package :holy-water.api.controller)

(defun deccot2plist (deccot)
  (flet ((get-class-name (deccot)
           (let ((symbol (class-name (class-of deccot))))
             (cond ((string= 'HOLY-WATER::RS_DECCOT-GITLAB symbol) "GITLAB")
                   (t    "????????")))))
    (list :|id|      (mito:object-id deccot)
          :|service| (get-class-name deccot))))

(defun find-deccots (angel)
  (mapcar #'deccot2plist
          (hw:find-deccots angel)))

(defun find-deccot-items (angel deccot)
  (declare (ignore angel))
  (when deccot
    (describe deccot)
    (hw:find-deccot-items deccot)))
