(in-package :holy-water)

;;;;;
;;;;; Impure ごとの Purge いちらん
;;;;;
(defun list-purge-by-impure-sql (impure table)
  (select ((:as :ev_purge_end.id          :purge_id)
           (:as :rs_angel.id              :angel_id)
           (:as :rs_angel.name            :angel_name)
           (:as :ev_purge_end.impure_id   :impure_id)
           (:as :ev_purge_end.description :purge_description)
           (:as :ev_purge_end.start       :purge_start)
           (:as :ev_purge_end.end         :purge_end)
           (:as (:- :ev_purge_end.end :ev_purge_end.start) :elapsed_time)
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
    (left-join :rs_angel
               :on (:= :ev_purge_end.angel_id :rs_angel.id))

    (where (:= :ev_purge_end.impure_id (mito:object-id impure)))))

(defun list-purge-by-impure-infrate! (rec)
  (timestamptz2timestamp! rec :|purge_start|)
  (timestamptz2timestamp! rec :|purge_end|)
  (interval2second!       rec :|elapsed_time|))

(defun list-purge-by-impure (impure)
  (nconc
   (fetch-all-list (list-purge-by-impure-sql impure :rs_impure_active)
                   :infrate! #'list-purge-by-impure-infrate!)
   (fetch-all-list (list-purge-by-impure-sql impure :rs_impure_finished)
                   :infrate! #'list-purge-by-impure-infrate!)))
