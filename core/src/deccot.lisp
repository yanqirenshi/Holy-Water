(in-package :holy-water)

(defun find-deccots (angel)
  (when angel
   (select-dao 'rs_deccot-gitlab
     (inner-join :th_ghost-shadow_deccot :on (:= :rs_deccot-gitlab.id                    :th_ghost-shadow_deccot.deccot_id))
     (inner-join :th_ghost-shadow_angel  :on (:= :th_ghost-shadow_deccot.ghost_shadow_id :th_ghost-shadow_angel.ghost_shadow_id))
     (where (:= :th_ghost-shadow_angel.angel_id (mito:object-id angel))))))


(defun get-angel-deccot-gitlab (angel &key id)
  (car (select-dao 'rs_deccot-gitlab
         (inner-join :th_ghost-shadow_deccot :on (:= :rs_deccot-gitlab.id                    :th_ghost-shadow_deccot.deccot_id))
         (inner-join :th_ghost-shadow_angel  :on (:= :th_ghost-shadow_deccot.ghost_shadow_id :th_ghost-shadow_angel.ghost_shadow_id))
         (where (:and (:= :th_ghost-shadow_angel.angel_id (mito:object-id angel))
                      (:= :rs_deccot-gitlab.id id))))))


(defun get-angel-deccot (angel service &key id)
  (format t "~S~%" (list angel service id))
  (cond ((string= service "GITLAB") (get-angel-deccot-gitlab angel :id id))
        (t nil)))


(defun find-deccot-items (deccot)
  (api.gitlab::find-issues :private-token (private-token deccot)))
