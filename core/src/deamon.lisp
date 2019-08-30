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
        (when (select-dao 'rs_impure-active
                (inner-join :th_deamon_impure
                            :on (:= :rs_impure_active.id :th_deamon_impure.impure_id))
                (where (:= :th_deamon_impure.deamon_id (object-id deamon))))
          (error "未浄化の Impure があります。そのため浄化できません。"))
        (setf (purged-at deamon) (local-time:now))
        (setf (updated-by deamon) by-id)
        (mito:update-dao deamon)))))
