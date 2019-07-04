(in-package :holy-water)

;;;;;
;;;;;
;;;;;
;; INNER JOIN ev_request_message_read
(defun list-requested-uncomplete-impures-sql (angel)
  (when angel
    (select  (:rs_impure.id
              :rs_impure.name
              :rs_impure.description

              (:as :ev_request.id :requested_id)
              (:as :ev_request.angel_id_to :angel_to_id)
              (:as :rs_angel_to.name :angel_to_name)
              (:as :ev_request.requested_at :requested_at)

              (:as :rs_deamon.id :deamon_id)
              (:as :rs_deamon.name :deamon_name)
              (:as :rs_deamon.name_short :deamon_name_short)

              (:as :rs_maledict.id :maledict_id)
              (:as :rs_maledict.name :maledict_name)
              (:as :rs_maledict.description :maledict_description)
              (:as "IMPURE_WAITING-FOR" :_class))
      (from (:as :rs_impure_active :rs_impure))
      (inner-join :ev_request
                  :on (:= :rs_impure.id :ev_request.impure_id))
      (left-join (:as :rs_angel :rs_angel_to)
                 :on (:= :ev_request.angel_id_to :rs_angel_to.id))
      (left-join :th_deamon_impure
                 :on (:= :th_deamon_impure.impure_id :rs_impure.id))
      (left-join :rs_deamon
                 :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
      (left-join :ev_collect_impure
                 :on (:= :rs_impure.id :ev_collect_impure.impure_id))
      (left-join :rs_maledict
                 :on (:= :ev_collect_impure.maledict_id :rs_maledict.id))
      (left-join :th_angel_maledict
                 :on (:= :rs_maledict.id :th_angel_maledict.maledict_id))
      (left-join (:as :rs_angel :rs_angel_now)
                 :on (:= :th_angel_maledict.angel_id :rs_angel_now.id))
      (where (:= :ev_request.angel_id_from (mito:object-id angel))))))

(defun list-requested-uncomplete-impures-infrate! (rec)
  (timestamptz2timestamp! rec :|requested_at|))

(defun list-requested-uncomplete-impures (angel)
  (fetch-all-list (list-requested-uncomplete-impures-sql angel)
                  :infrate! #'list-requested-uncomplete-impures-infrate!))
