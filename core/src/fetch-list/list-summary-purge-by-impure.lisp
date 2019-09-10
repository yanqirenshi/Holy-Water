(in-package :holy-water)


;;;;;
;;;;; List Summary Purge by Deamon
;;;;;
(defun list-summary-purge-by-impure-sql (table &key deamon)
  (sxql:yield
   (select ((:as :rs_impure.id   :impure_id)
            (:as (:max :rs_impure.name) :impure_name)
            (:as (:max :rs_impure.description) :impure_description)
            (:as (:max :rs_deamon.id) :deamon_id)
            (:as (:max :rs_deamon.name)        :deamon_name)
            (:as (:max :rs_deamon.name_short)  :deamon_name_short)
            (:as (:to_char :ev_purge.start :@YYYY-MM-DD) :date)
            (:as (:count :ev_purge.id) :impure_count)
            (:as (:sum (:- :ev_purge.end :ev_purge.start)) :elapsed_time))
     (from (:as :ev_purge_end :ev_purge))
     (inner-join (:as table :rs_impure)
                 :on (:= :ev_purge.impure_id :rs_impure.id))
     (left-join :th_deamon_impure :on (:= :rs_impure.id :th_deamon_impure.impure_id))
     (left-join :rs_deamon :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (where (:= :rs_deamon.id (object-id deamon)))
     (group-by :rs_impure.id
               (:to_char :ev_purge.start :@YYYY-MM-DD))
     (sxql:order-by (:desc :elapsed_time)))))

(defun list-summary-purge-by-impure-fix-sql (sql-str)
  (flet ((replace1 (str)
           (let ((regex "ev_purge.end - ev_purge.start")
                 (replacement "extract(epoch from ev_purge.end) - extract(epoch from ev_purge.start)"))
             (cl-ppcre:regex-replace regex str replacement)))
         (replace2 (str)
           (let ((regex "@yyyy-mm-dd")
                 (replacement "'YYYY-MM-DD'"))
             (cl-ppcre:regex-replace-all regex str replacement))))
    (replace2 (replace1 sql-str))))


(defun list-summary-purge-by-impure-core (table &key deamon)
  (multiple-value-bind (sql vals)
      (list-summary-purge-by-impure-sql table :deamon deamon)
    (let ((results (fetch-list (list-summary-purge-by-impure-fix-sql sql)
                               vals)))
      results)))

(defun list-summary-purge-by-impure (&key deamon)
  (nconc (list-summary-purge-by-impure-core :rs_impure_active    :deamon deamon)
         (list-summary-purge-by-impure-core :rs_impure_finished  :deamon deamon)
         (list-summary-purge-by-impure-core :rs_impure_discarded :deamon deamon)))
