(in-package :holy-water)

(defun list-impures-by-deamon-sql (table &key deamon)
  (select ((:as :rs_deamon.id                  :deamon_id)
           (:as :rs_deamon.name                :deamon_name)
           (:as :rs_deamon.name_short          :deamon_name_short)
           (:as :rs_deamon.description         :deamon_description)
           (:as :rs_impure.id                  :id)
           (:as :rs_impure.name                :name)
           (:as :rs_impure.description         :description)
           (:as :rs_impure.created_at          :created_at)
           (if (eq table :rs_impure_finished)  :finished_at  '(:as :null :finished_at))
           (if (eq table :rs_impure_finished)  :finished_by  '(:as :null :finished_by))
           (if (eq table :rs_impure_discarded) :discarded_at '(:as :null :discarded_at))
           (:as :rs_maledict.id                :maledict_id)
           (:as :rs_maledict.name              :maledict_name)
           (:as :rs_maledict.description       :maledict_description)
           (:as :rs_maledict.order             :maledict_order)
           (:as :rs_maledict.deletable         :maledict_deletable))
    (from :rs_deamon)
    (inner-join :th_deamon_impure
                :on (:= :rs_deamon.id :th_deamon_impure.deamon_id))
    (inner-join (:as table :rs_impure)
                :on (:= :th_deamon_impure.impure_id :rs_impure.id))
    (inner-join :ev_collect_impure
                :on (:= :rs_impure.id :ev_collect_impure.impure_id))
    (inner-join :rs_maledict
                :on (:= :ev_collect_impure.maledict_id :rs_maledict.id))
    (where (:= :rs_deamon.id (mito:object-id deamon)))))

(defun list-impures-by-deamon-infrate! (rec)
  (timestamptz2timestamp! rec :|finished_at|)
  (timestamptz2timestamp! rec :|discarded_at|))

(defun list-impures-by-deamon-core (deamon tables)
  (when-let ((table (car tables)))
    (nconc (fetch-all-list (list-impures-by-deamon-sql table :deamon deamon)
                           :infrate! #'list-impures-by-deamon-infrate!)
           (list-impures-by-deamon-core deamon (cdr tables)))))

(defun list-impures-by-deamon (&key deamon)
  (when deamon
    (list-impures-by-deamon-core deamon
                                 '(:rs_impure_active
                                   :rs_impure_finished
                                   :rs_impure_discarded))))

;;;;;
;;;;; list-impures-purged-time-by-deamon
;;;;;
(defun list-impures-purged-time-by-deamon-sql (table &key deamon)
  (select ((:as :rs_impure.id :impure_id)
           (:as (:min :ev_purge_end.start) :purge_start)
           (:as (:max :ev_purge_end.end)   :purge_end)
           (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :purge_elapsed_time_total))
    (from :rs_deamon)
    (inner-join :th_deamon_impure
                :on (:= :rs_deamon.id :th_deamon_impure.deamon_id))
    (inner-join (:as table :rs_impure)
                :on (:= :th_deamon_impure.impure_id :rs_impure.id))
    (inner-join :ev_collect_impure
                :on (:= :rs_impure.id :ev_collect_impure.impure_id))
    (inner-join :rs_maledict
                :on (:= :ev_collect_impure.maledict_id :rs_maledict.id))
    (inner-join :ev_purge_end
                :on (:= :rs_impure.id :ev_purge_end.impure_id))
    (where (:= :rs_deamon.id (mito:object-id deamon)))
    (sxql:group-by :rs_impure.id)))

(defun list-impures-purged-time-by-deamon-infrate! (rec)
  (timestamptz2timestamp! rec :|purge_start|)
  (timestamptz2timestamp! rec :|purge_end|)
  (interval2second!       rec :|purge_elapsed_time_total|))

(defun list-impures-purged-time-by-deamon-core (deamon tables)
  (when-let ((table (car tables)))
    (nconc (fetch-all-list (list-impures-purged-time-by-deamon-sql table :deamon deamon)
                           :infrate! #'list-impures-purged-time-by-deamon-infrate!)
           (list-impures-purged-time-by-deamon-core deamon (cdr tables)))))

(defun list-impures-purged-time-by-deamon (&key deamon)
  (when deamon
    (list-impures-purged-time-by-deamon-core deamon
                                             '(:rs_impure_active
                                               :rs_impure_finished
                                               :rs_impure_discarded))))
