(in-package :holy-water)

(defun find-orthodox-duties ()
  (select-dao 'rs_orthodox-duty))
