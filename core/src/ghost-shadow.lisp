(in-package :holy-water)

(defun get-ghost-shadow (&key ghost-id angel)
  (cond (ghost-id
         (mito:find-dao 'rs_ghost-shadow :ghost-id ghost-id))
        (angel
         (first (mito:select-dao 'rs_ghost-shadow
                  (inner-join :th_ghost_shadow_angel
                              :on (:= :rs_ghost_shadow.id :th_ghost_shadow_angel.ghost_shadow_id))
                  (where (:= :th_ghost_shadow_angel.angel_id (mito:object-id angel))))))))


 (defun make-ghost-shadow (ghost-id &key creator)
  (when (get-ghost-shadow :ghost-id ghost-id)
    (error "Aledy exist. ghost-id=~S" ghost-id))
  (mito:create-dao 'rs_ghost-shadow
                   :ghost-id ghost-id
                   :created-by (or creator (mito:object-id creator) nil)
                   :updated-by (or creator (mito:object-id creator) nil)))


(defgeneric make-ghost-shadow_angel (ghost-shadow angel &key creator)
  (:method ((ghost-shadow rs_ghost-shadow) (angel rs_angel) &key creator)
    (mito:create-dao 'th_ghost-shadow_angel
                     :ghost-shadow-id (mito:object-id ghost-shadow)
                     :angel-id        (mito:object-id angel)
                     :created-by      (or creator (mito:object-id creator) nil)
                     :updated-by      (or creator (mito:object-id creator) nil))))
