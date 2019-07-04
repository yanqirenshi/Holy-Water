(in-package :holy-water)


;;;;;
;;;;; List Summary Purge by Deamon
;;;;;
(defun list-summary-purge-by-deamon-sql (angel &key from to)
  (sxql:yield
   (select ((:as :th_deamon_impure.deamon_id  :deamon_id)
            (:as (:max :rs_deamon.name)       :deamon_name)
            (:as (:max :rs_deamon.name_short) :deamon_name_short)
            (:as (:count :*)                  :purge_count)
            (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :elapsed_time))
     (from :ev_purge_end)
     (left-join :th_deamon_impure
                :on (:= :ev_purge_end.impure_id :th_deamon_impure.impure_id))
     (left-join :rs_deamon
                :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (where (:and (:= :ev_purge_end.angel_id (mito:object-id angel))
                  (:or (:and (:<= :ev_purge_end.start from)
                             (:>= :ev_purge_end.end   from))
                       (:and (:>= :ev_purge_end.start from)
                             (:<  :ev_purge_end.start to)))))
     (group-by :th_deamon_impure.deamon_id))))

(defun list-summary-purge-by-deamon (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-summary-purge-by-deamon-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|elapsed_time|)
              (if (eq :null (getf rec :|elapsed_time|))
                  0
                  (second (assoc :seconds (getf rec :|elapsed_time|))))))
      results)))
