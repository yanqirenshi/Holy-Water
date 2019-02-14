(in-package :holy-water)

(defun get-orthodox (&key id)
  (when id
    (find-dao 'rs_orthodox :id id)))

(defun find-orthodoxs ()
  (select-dao 'rs_orthodox))
