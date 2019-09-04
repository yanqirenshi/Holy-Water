(in-package :holy-water)


;;;;;
;;;;; List Summary Purge by Deamon
;;;;;
(defun list-summary-purge-by-angel-span-sql (angel &key from to)
  (sxql:yield
   (select ((:as :rs_deamon.id :deamon_id)
            (:as (:max :rs_deamon.name)        :deamon_name)
            (:as (:max :rs_deamon.name_short)  :deamon_name_short)
            (:as (:max :rs_deamon.description) :deamon_description)
            (:as (:max :rs_deamon.purged_at)   :deamon_purged_at)
            (:as (:to_char :ev_purge.start :@YYYY-MM-DD) :date)
            (:as (:count :ev_purge.id) :impure_count)
            (:as (:sum (:- :ev_purge.end :ev_purge.start)) :elapsed_time))
     (from (:as :ev_purge_end :ev_purge))
     (left-join :th_deamon_impure :on (:= :ev_purge.impure_id :th_deamon_impure.impure_id))
     (left-join :rs_deamon :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (where (:and
             (:= :ev_purge.angel_id (object-id angel))
             (:or (:and (:>= :ev_purge.start from)
                        (:<  :ev_purge.start to))
                  (:and (:<  :ev_purge.start from)
                        (:>= :ev_purge.end   from)))))
     (group-by :rs_deamon.id
               (:to_char :ev_purge.start :@YYYY-MM-DD)))))

(defun list-summary-purge-by-angel-span-fix-sql (sql-str)
  (flet ((replace1 (str)
           (let ((regex "ev_purge.end - ev_purge.start")
                 (replacement "extract(epoch from ev_purge.end) - extract(epoch from ev_purge.start)"))
             (cl-ppcre:regex-replace regex str replacement)))
         (replace2 (str)
           (let ((regex "@yyyy-mm-dd")
                 (replacement "'YYYY-MM-DD'"))
             (cl-ppcre:regex-replace-all regex str replacement))))
    (replace2 (replace1 sql-str))))


(defun list-summary-purge-by-angel-span (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-summary-purge-by-angel-span-sql angel :from from :to to)
    (print (list-summary-purge-by-angel-span-fix-sql sql))
    (let ((results (fetch-list (list-summary-purge-by-angel-span-fix-sql sql)
                               vals)))
      results)))
