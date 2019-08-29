(in-package :holy-water)


;;;;;
;;;;; List Summary Purge by Deamon
;;;;;
(defun list-summary-purge-by-angel-deamon-span-sql (angel &key from to)
  (sxql:yield
   (select ((:as :rs_deamon.id :deamon_id)
            (:as (:max :rs_deamon.name) :deamon_name)
            (:as (:max :rs_deamon.name_short) :deamon_name_short)
            (:as (:sum (:- :ev_purge.end :ev_purge.start)) :puge_elapsed_time))
     (from (:as :ev_purge_end :ev_purge))
     (inner-join :th_deamon_impure
                 :on (:= :ev_purge.impure_id :th_deamon_impure.impure_id))
     (left-join :rs_deamon
                :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (where (:and (:= :ev_purge.angel_id (mito:object-id angel))
                  (:or (:and (:>= :ev_purge.start from)
                             (:<  :ev_purge.start to))
                       (:and (:<  :ev_purge.start from)
                             (:>= :ev_purge.end   from)))))
     (group-by :rs_deamon.id))))

(defun list-summary-purge-by-angel-deamon-span-fix-sql (sql-str)
  (let ((regex "ev_purge.end - ev_purge.start")
        (replacement "extract(epoch from ev_purge.end) - extract(epoch from ev_purge.start)"))
    (cl-ppcre:regex-replace regex sql-str replacement)))


(defun list-summary-purge-by-angel-deamon-span (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-summary-purge-by-angel-deamon-span-sql angel :from from :to to)
    (let ((results (fetch-list (list-summary-purge-by-angel-deamon-span-fix-sql sql)
                               vals)))
      results)))
