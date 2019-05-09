(in-package :holy-water)

(defun fetch-list (sql vals)
  (dbi:fetch-all (apply #'dbi:execute (dbi:prepare mito:*connection* sql) vals)))

;;;;;
;;;;; Summay Purge Time by Date-Damon
;;;;;
(defun list-summay-purge-time-by-date-damon-sql (angel start end)
  (multiple-value-bind (sql vals)
      (sxql:yield
       (select (:ev_purge_end.angel_id
                (:as (:to_char :ev_purge_end.start :@@@format-YYYY-MM-DD) :date)
                (:as (:max :rs_deamon.name) :deamon_name)
                (:as :rs_deamon.id :deamon_id)
                (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :elapsed_time))
         (from  :ev_purge_end)
         (left-join :th_deamon_impure
                    :on (:= :ev_purge_end.impure_id :th_deamon_impure.impure_id))
         (left-join :rs_deamon
                    :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
         (where (:and (:= :ev_purge_end.angel_id (mito:object-id angel))
                      (:>= :ev_purge_end.start start)
                      (:<  :ev_purge_end.start end)))
         (group-by :ev_purge_end.angel_id
                   (:to_char :ev_purge_end.start :@@@format-YYYY-MM-DD)
                   :rs_deamon.id)))
    (values (cl-ppcre:regex-replace-all "@@@format-yyyy-mm-dd" sql "'YYYY-MM-DD'")
            vals)))

(defun list-summay-purge-time-by-date-damon (&key angel start end)
  (multiple-value-bind (sql vals)
      (list-summay-purge-time-by-date-damon-sql angel start end)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|elapsed_time|)
              (second (assoc :seconds (getf rec :|elapsed_time|)))))
      results)))
