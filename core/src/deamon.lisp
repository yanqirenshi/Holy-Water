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


(defgeneric purge-deamon (deamon &key editor)
  (:method ((deamon rs_deamon) &key editor)
    (let ((by-id (creator-id editor)))
      (unless (purged-at deamon)
        (setf (purged-at deamon) (local-time:now))
        (setf (updated-by deamon) by-id)
        (mito:update-dao deamon)))))
