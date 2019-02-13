(in-package :holy-water)

(defun get-deamon (&key id)
  (when id
    (find-dao 'rs_deamon :id id)))

(defun find-deamons ()
  (select-dao 'rs_deamon))
