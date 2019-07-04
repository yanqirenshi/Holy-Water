(in-package :holy-water)


;;;;;
;;;;; List Cemeteries
;;;;;
(defun list-cemeteries-sql (angel &key from to)
  (sxql:yield
   (select ((:as :rs_impure_finished.id                 :impure_id)
            (:as (:max :rs_impure_finished.name)        :impure_name)
            (:as (:max :rs_impure_finished.description) :impure_description)
            (:as (:max :rs_impure_finished.finished_at) :impure_finished_at)
            (:as (:max :th_deamon_impure.deamon_id)     :deamon_id)
            (:as (:max :rs_deamon.name)                 :deamon_name)
            (:as (:max :rs_deamon.name_short)           :deamon_name_short)
            (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :elapsed_time)
            (:as (:count :ev_purge_end.id)              :purge_count))
     (from :rs_impure_finished)
     (left-join :th_deamon_impure
                :on (:= :rs_impure_finished.id :th_deamon_impure.impure_id))
     (left-join :rs_deamon
                :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (left-join :ev_purge_end
                :on (:= :rs_impure_finished.id :ev_purge_end.impure_id))
     (where (:and (:=  :rs_impure_finished.finished_by (mito:object-id angel))
                  (:>= :rs_impure_finished.finished_at from)
                  (:<  :rs_impure_finished.finished_at to)))
     (group-by :rs_impure_finished.id))))

(defun list-cemeteries (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-cemeteries-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|impure_finished_at|)
              (local-time:format-timestring nil (local-time:universal-to-timestamp (getf rec :|impure_finished_at|))))
        (setf (getf rec :|elapsed_time|)
              (if (eq :null (getf rec :|elapsed_time|))
                  0
                  (second (assoc :seconds (getf rec :|elapsed_time|))))))
      results)))
