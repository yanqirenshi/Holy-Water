(in-package :holy-water)

(defun get-deamon (&key id)
  (when id
    (find-dao 'rs_deamon :id id)))

(defun find-deamons ()
  (select-dao 'rs_deamon))

(defun create-deamon (name name_short &key creator (description ""))
  (let ((by-id (creator-id creator)))
    (create-dao 'rs_deamon
                :name name
                :name-short name_short
                :description description
                :created-by by-id
                :updated-by by-id)))
