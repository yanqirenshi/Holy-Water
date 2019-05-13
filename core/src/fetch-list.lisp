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



;;;;;
;;;;; Angel ごと の Purge いちらん
;;;;;
(defun list-purge-by-angel-sql-template (table angel &key from to)
  (select ((:as :ev_purge_end.id          :purge_id)
           (:as :ev_purge_end.angel_id    :angel_id)
           (:as :ev_purge_end.impure_id   :impure_id)
           (:as :ev_purge_end.description :purge_description)
           (:as :ev_purge_end.start       :purge_start)
           (:as :ev_purge_end.end         :purge_end)
           (:as :rs_impure.id             :impure_id)
           (:as :rs_impure.name           :impure_name)
           (:as :rs_impure.description    :impure_description)
           (:as :rs_deamon.id             :deamon_id)
           (:as :rs_deamon.name           :deamon_name)
           (:as :rs_deamon.name_short     :deamon_name_short))
    (from :ev_purge_end)
    (inner-join (:as table :rs_impure)
                :on (:= :ev_purge_end.impure_id :rs_impure.id))
    (left-join :th_deamon_impure
               :on (:= :rs_impure.id :th_deamon_impure.impure_id))
    (left-join :rs_deamon
               :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
    (where (:and (:= :ev_purge_end.angel_id (mito:object-id angel))
                 (:or (:and (:<= :ev_purge_end.start from)
                            (:>= :ev_purge_end.end   from))
                      (:and (:>= :ev_purge_end.start from)
                            (:<  :ev_purge_end.start to)))))))

(defun list-purge-by-angel-sql (angel &key from to)
  (sxql:yield
   (union-all-queries
    (list-purge-by-angel-sql-template :rs_impure_active   angel :from from :to to)
    (list-purge-by-angel-sql-template :rs_impure_finished angel :from from :to to))))

(defun list-purge-by-angel (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-purge-by-angel-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|purge_start|)
              (local-time:format-timestring nil (local-time:universal-to-timestamp (getf rec :|purge_start|))))
        (setf (getf rec :|purge_end|)
              (local-time:format-timestring nil (local-time:universal-to-timestamp (getf rec :|purge_end|)))))
      results)))


;;;;;
;;;;; 墓標の日別/悪魔別の数
;;;;;
;; select to_char(finished_at, 'YYYY-MM-DD')
;;      , 0
;;      , 'TOTAL'
;;      , count(*)
;;   from rs_impure_finished
;;  where updated_by = 1
;;    and finished_at >= '2019-05-01'
;;    and finished_at <  '2019-05-10'
;; group by to_char(finished_at, 'YYYY-MM-DD')
(defun list-summay-impure-cemeteries-by-date-damon-sql (angel &key from to)
  (multiple-value-bind (sql vals)
      (sxql:yield
       (select ((:to_char :rs_impure_finished.finished_at :@@@format-YYYY-MM-DD)
                :th_deamon_impure.deamon_id
                :rs_deamon.name
                (:count :*))
         (from :rs_impure_finished)
         (left-join :th_deamon_impure
                    :on (:= :rs_impure_finished.id :th_deamon_impure.impure_id))
         (left-join :rs_deamon
                    :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
         (where (:and (:=  :rs_impure_finished.finished_by (mito:object-id angel))
                      (:>= :rs_impure_finished.finished_at from)
                      (:<  :rs_impure_finished.finished_at to)))
         (group-by (:to_char :rs_impure_finished.finished_at :@@@format-YYYY-MM-DD)
                   :th_deamon_impure.deamon_id
                   :rs_deamon.name)))
    (values (cl-ppcre:regex-replace-all "@@@format-yyyy-mm-dd" sql "'YYYY-MM-DD'")
            vals)))

(defun list-summay-impure-cemeteries-by-date-damon (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-summay-impure-cemeteries-by-date-damon-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|elapsed_time|)
              (second (assoc :seconds (getf rec :|elapsed_time|)))))
      results)))
