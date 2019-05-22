(in-package :holy-water)

(defun ghost-angel (&key ghost-id)
  (car (select-dao 'rs_angel
         (inner-join :th_ghost_shadow_angel
                     :on (:= :rs_angel.id :th_ghost_shadow_angel.angel_id))
         (inner-join :rs_ghost_shadow
                     :on (:= :th_ghost_shadow_angel.ghost_shadow_id :rs_ghost_shadow.id))
         (where (:= :rs_ghost_shadow.id ghost-id)))))


(defgeneric angel-impure (angel &key id)
  (:method ((angel rs_angel) &key id)
    (when id
      (or (angel-impure-core 'rs_impure-active    angel id)
          (angel-impure-core 'rs_impure-finished  angel id)
          (angel-impure-core 'rs_impure-discarded angel id)))))


(defun impure-deamon (impure)
  (when impure
    (car (select-dao 'rs_deamon
           (inner-join :th_deamon_impure
                       :on (:= :rs_deamon.id :th_deamon_impure.deamon_id))
           (where (:= :th_deamon_impure.impure_id (mito:object-id impure)))))))

(defun impure-maledict (impure)
  (when impure
    (car (select-dao 'rs_maledict
           (inner-join :ev_collect_impure
                       :on (:= :rs_maledict.id :ev_collect_impure.maledict_id))
           (where (:= :ev_collect_impure.impure_id (mito:object-id impure)))))))

;;;;;
;;;;; impure-purges
;;;;;
(defun impure-purge-list-sxql (impure)
  (when impure
    (select (:ev_purge_end.id
             :ev_purge_end.angel_id
             (:as :rs_angel.name :angel_name)
             :ev_purge_end.impure_id
             (:as :rs_impure.name        :impure_name)
             (:as :rs_impure.description :impure_description)
             :ev_purge_end.description
             :ev_purge_end.start
             :ev_purge_end.end
             (:as (:- :ev_purge_end.end :ev_purge_end.start) :elapsed_time)
             :ev_purge_end.created_at
             :ev_purge_end.created_by
             :ev_purge_end.updated_at
             :ev_purge_end.updated_by)
      (from :ev_purge_end)
      (left-join :rs_angel
                 :on (:= :ev_purge_end.angel_id :rs_angel.id))
      (left-join (:as
                  (sxql:union-all-queries
                   (select (:id :name :description) (from :rs_impure_active)    (where (:= :rs_impure_active.id    (mito:object-id impure))))
                   (select (:id :name :description) (from :rs_impure_finished)  (where (:= :rs_impure_finished.id  (mito:object-id impure))))
                   (select (:id :name :description) (from :rs_impure_discarded) (where (:= :rs_impure_discarded.id (mito:object-id impure)))))
                  :rs_impure)
                 :on (:= :ev_purge_end.impure_id :rs_impure.id))
      (where (:= :ev_purge_end.impure_id (mito:object-id impure))))))

(defun impure-purge-list-infrate (rec)
  (timestamptz2timestamp! rec :|created_at|)
  (timestamptz2timestamp! rec :|updated_at|)
  (timestamptz2timestamp! rec :|start|)
  (timestamptz2timestamp! rec :|end|)
  (interval2second!       rec :|elapsed_time|))


(defun impure-purge-list (impure)
  (fetch-all-list (impure-purge-list-sxql impure)
                  :infrate! #'impure-purge-list-infrate))


;;;;;
;;;;; impure-purges
;;;;;
(defun impure-spell-list-sxql (impure)
  (select (:ev_incantation_solo.id
           :ev_incantation_solo.impure_id
           (:as :rs_impure.name        :impure_name)
           (:as :rs_impure.description :impure_description)
           :ev_incantation_solo.angel_id
           (:as :rs_angel.name :angel_name)
           :ev_incantation_solo.spell
           :ev_incantation_solo.incantation_at
           :ev_incantation_solo.created_at
           :ev_incantation_solo.created_by
           :ev_incantation_solo.updated_at
           :ev_incantation_solo.updated_by)
    (from :ev_incantation_solo)
    (left-join :rs_angel
               :on (:= :ev_incantation_solo.angel_id :rs_angel.id))
    (left-join (:as
                (sxql:union-all-queries
                 (select (:id :name :description) (from :rs_impure_active)    (where (:= :rs_impure_active.id    (mito:object-id impure))))
                 (select (:id :name :description) (from :rs_impure_finished)  (where (:= :rs_impure_finished.id  (mito:object-id impure))))
                 (select (:id :name :description) (from :rs_impure_discarded) (where (:= :rs_impure_discarded.id (mito:object-id impure)))))
                :rs_impure)
               :on (:= :ev_incantation_solo.impure_id :rs_impure.id))
    (where (:= :ev_incantation_solo.impure_id (mito:object-id impure)))))

(defun impure-spell-list-infrate! (rec)
  (timestamptz2timestamp! rec :|created_at|)
  (timestamptz2timestamp! rec :|updated_at|)
  (timestamptz2timestamp! rec :|incantation_at|))

(defun impure-spell-list (impure)
  (fetch-all-list (impure-spell-list-sxql impure)
                  :infrate! #'impure-spell-list-infrate!))


;;;;;
;;;;; impure-requests
;;;;;
(defun impure-request-list-unread-sxql (impure)
  (select (:ev_request_message_unread.id
           :ev_request_message_unread.impure_id
           (:as :rs_impure.name        :impure_name)
           (:as :rs_impure.description :impure_description)
           (:as :ev_request_message_unread.angel_id_from :angel_from_id)
           (:as :rs_angel_from.name :angel_from_name)
           (:as :ev_request_message_unread.angel_id_to :angel_to_id)
           (:as :rs_angel_to.name :angel_to_name)
           :ev_request_message_unread.contents
           :ev_request_message_unread.messaged_at
           :ev_request_message_unread.created_at
           :ev_request_message_unread.created_by
           :ev_request_message_unread.updated_at
           :ev_request_message_unread.updated_by)
    (from :ev_request_message_unread)
    (left-join (:as :rs_angel :rs_angel_from)
               :on (:= :ev_request_message_unread.angel_id_from :rs_angel_from.id))
    (left-join (:as :rs_angel :rs_angel_to)
               :on (:= :ev_request_message_unread.angel_id_to :rs_angel_to.id))
    (left-join (:as
                (sxql:union-all-queries
                 (select (:id :name :description) (from :rs_impure_active)    (where (:= :rs_impure_active.id    (mito:object-id impure))))
                 (select (:id :name :description) (from :rs_impure_finished)  (where (:= :rs_impure_finished.id  (mito:object-id impure))))
                 (select (:id :name :description) (from :rs_impure_discarded) (where (:= :rs_impure_discarded.id (mito:object-id impure)))))
                :rs_impure)
               :on (:= :ev_request_message_unread.impure_id :rs_impure.id))
    (where (:= :ev_request_message_unread.impure_id (mito:object-id impure)))))

(defun impure-request-list-unread-infrate! (rec)
  (timestamptz2timestamp! rec :|created_at|)
  (timestamptz2timestamp! rec :|updated_at|)
  (timestamptz2timestamp! rec :|messaged_at|))

(defun impure-request-list-read-sxql (impure)
  (select (:ev_request_message_read.id
           :ev_request_message_read.impure_id
           (:as :rs_impure.name        :impure_name)
           (:as :rs_impure.description :impure_description)
           (:as :ev_request_message_read.angel_id_from :angel_from_id)
           (:as :rs_angel_from.name :angel_from_name)
           (:as :ev_request_message_read.angel_id_to :angel_to_id)
           (:as :rs_angel_to.name :angel_to_name)
           :ev_request_message_read.contents
           :ev_request_message_read.messaged_at
           :ev_request_message_read.readed_at
           :ev_request_message_read.created_at
           :ev_request_message_read.created_by
           :ev_request_message_read.updated_at
           :ev_request_message_read.updated_by)
    (from :ev_request_message_read)
    (left-join (:as :rs_angel :rs_angel_from)
               :on (:= :ev_request_message_read.angel_id_from :rs_angel_from.id))
    (left-join (:as :rs_angel :rs_angel_to)
               :on (:= :ev_request_message_read.angel_id_to :rs_angel_to.id))
    (left-join (:as
                (sxql:union-all-queries
                 (select (:id :name :description) (from :rs_impure_active)    (where (:= :rs_impure_active.id    (mito:object-id impure))))
                 (select (:id :name :description) (from :rs_impure_finished)  (where (:= :rs_impure_finished.id  (mito:object-id impure))))
                 (select (:id :name :description) (from :rs_impure_discarded) (where (:= :rs_impure_discarded.id (mito:object-id impure)))))
                :rs_impure)
               :on (:= :ev_request_message_read.impure_id :rs_impure.id))
    (where (:= :ev_request_message_read.impure_id (mito:object-id impure)))))

(defun impure-request-list-read-infrate! (rec)
  (timestamptz2timestamp! rec :|created_at|)
  (timestamptz2timestamp! rec :|updated_at|)
  (timestamptz2timestamp! rec :|messaged_at|)
  (timestamptz2timestamp! rec :|readed_at|))

(defun impure-request-list (impure)
  (nconc (fetch-all-list (impure-request-list-unread-sxql impure) :infrate! #'impure-request-list-unread-infrate!)
         (fetch-all-list (impure-request-list-read-sxql   impure) :infrate! #'impure-request-list-read-infrate!)))


;;;;;
;;;;; impure-chains
;;;;;
(defun impure-chain-list (impure)
  (when impure
    (list :|node| nil
          :|edge| nil)))
