(in-package :holy-water)


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
       (select ((:as (:to_char :rs_impure_finished.finished_at :@@@format-YYYY-MM-DD) :finished_at)
                (:as :th_deamon_impure.deamon_id  :deamon_id)
                (:as (:max :rs_deamon.name)       :deamon_name)
                (:as (:max :rs_deamon.name_short) :deamon_name_short)
                (:as (:count :*)                  :purge_count))
         (from :rs_impure_finished)
         (left-join :th_deamon_impure
                    :on (:= :rs_impure_finished.id :th_deamon_impure.impure_id))
         (left-join :rs_deamon
                    :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
         (where (:and (:=  :rs_impure_finished.finished_by (mito:object-id angel))
                      (:>= :rs_impure_finished.finished_at from)
                      (:<  :rs_impure_finished.finished_at to)))
         (group-by (:to_char :rs_impure_finished.finished_at :@@@format-YYYY-MM-DD)
                   :th_deamon_impure.deamon_id)))
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
