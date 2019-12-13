(in-package :holy-water)


;;;;;
;;;;; maledict impures
;;;;;
(defun list-maledict-impures-sql (angel maledict)
  (select ((:as :ev_collect_impure.impure_id :id)
           :rs_impure.name
           :rs_impure.description
           (:as :ev_purge_start.id             :purge_id)
           (:as :ev_purge_start.start          :purge_started_at)
           (:as :th_deamon_impure.deamon_id    :deamon_id)
           (:as :rs_deamon.name                :deamon_name)
           (:as :rs_deamon.name_short          :deamon_name_short)
           (:as :ev_collect_impure.maledict_id :maledict_id)
           (:as :rs_maledict.name              :maledict_name)
           (:as :rs_maledict.description       :maledict_description)
           (:as :rs_maledict.order             :maledict_order)
           (:as :rs_maledict.deletable         :maledict_deletable)
           (:as "IMPURE"                       :_class))
    (from :th_angel_maledict)
    (left-join :ev_collect_impure
               :on (:= :th_angel_maledict.maledict_id :ev_collect_impure.maledict_id))
    (left-join (:as :rs_impure_active :rs_impure)
               :on (:= :ev_collect_impure.impure_id :rs_impure.id))
    (left-join :th_deamon_impure
               :on (:= :rs_impure.id :th_deamon_impure.impure_id))
    (left-join :rs_deamon
               :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
    (left-join :ev_purge_start
               :on (:= :ev_collect_impure.impure_id :ev_purge_start.impure_id))
    (left-join :rs_maledict
               :on (:= :th_angel_maledict.maledict_id :rs_maledict.id))
    (where (:and (:not-null :ev_collect_impure.impure_id)
                 (:= :th_angel_maledict.angel_id (mito:object-id angel))
                 (:= :th_angel_maledict.maledict_id (mito:object-id maledict))))))


(defun list-maledict-impures! (rec)
  (timestamptz2timestamp! rec :|purge_started_at|))


(defun list-maledict-impures (angel maledict)
  (when (and angel maledict)
    (fetch-all-list (list-maledict-impures-sql angel maledict)
                    :infrate! #'list-maledict-impures!)))
