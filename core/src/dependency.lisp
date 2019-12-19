(in-package :holy-water)

(defun ghost-angel (&key ghost ghost-id)
  (let ((ghost-id (cond (ghost (ghost-id ghost))
                        (ghost-id ghost-id))))
    (when ghost-id
      (car (select-dao 'rs_angel
             (inner-join :th_ghost_shadow_angel
                         :on (:= :rs_angel.id :th_ghost_shadow_angel.angel_id))
             (inner-join :rs_ghost_shadow
                         :on (:= :th_ghost_shadow_angel.ghost_shadow_id :rs_ghost_shadow.id))
             (where (:= :rs_ghost_shadow.ghost_id ghost-id)))))))


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

(defun impure-angel (impure)
  (when impure
    (car (select-dao 'rs_angel
           (inner-join :th_angel_maledict
                       :on (:= :rs_angel.id :th_angel_maledict.angel_id))
           (inner-join :ev_collect_impure
                       :on (:= :th_angel_maledict.maledict_id :ev_collect_impure.maledict_id))
           (where (:= :ev_collect_impure.impure_id (mito:object-id impure)))))))

(defun maledict-angel (maledict)
  (when maledict
    (car (select-dao 'rs_angel
           (inner-join :th_angel_maledict
                       :on (:= :rs_angel.id :th_angel_maledict.angel_id))
           (where (:= :th_angel_maledict.maledict_id (mito:object-id maledict)))))))


;;;;;
;;;;; impure-purges
;;;;;
(defun impure-purge-list-sxql (table &key impure)
  (when impure
    (select (:ev_purge.id
             :ev_purge.angel_id
             (:as :rs_angel.name :angel_name)
             :ev_purge.impure_id
             (:as :rs_impure.name        :impure_name)
             (:as :rs_impure.description :impure_description)
             :ev_purge.description
             :ev_purge.start
             (if (eq :ev_purge_end table)
                 :ev_purge.end
                 '(:as :null :end))
             (if (eq :ev_purge_end table)
                 '(:as (:- :ev_purge.end :ev_purge.start) :elapsed_time)
                 '(:as :null :elapsed_time))
             :ev_purge.created_at
             :ev_purge.created_by
             :ev_purge.updated_at
             :ev_purge.updated_by)
      (from (:as table :ev_purge))
      (left-join :rs_angel
                 :on (:= :ev_purge.angel_id :rs_angel.id))
      (left-join (:as
                  (sxql:union-all-queries
                   (select (:id :name :description) (from :rs_impure_active)    (where (:= :rs_impure_active.id    (mito:object-id impure))))
                   (select (:id :name :description) (from :rs_impure_finished)  (where (:= :rs_impure_finished.id  (mito:object-id impure))))
                   (select (:id :name :description) (from :rs_impure_discarded) (where (:= :rs_impure_discarded.id (mito:object-id impure)))))
                  :rs_impure)
                 :on (:= :ev_purge.impure_id :rs_impure.id))
      (where (:= :ev_purge.impure_id (mito:object-id impure))))))


(defun impure-purge-list-infrate (rec)
  (timestamptz2timestamp! rec :|created_at|)
  (timestamptz2timestamp! rec :|updated_at|)
  (timestamptz2timestamp! rec :|start|)
  (timestamptz2timestamp! rec :|end|)
  (interval2second!       rec :|elapsed_time|))


(defun impure-purge-list (impure)
  (nconc (fetch-all-list (impure-purge-list-sxql :ev_purge_start :impure impure)
                         :infrate! #'impure-purge-list-infrate)
         (fetch-all-list (impure-purge-list-sxql :ev_purge_end   :impure impure)
                         :infrate! #'impure-purge-list-infrate)))


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



;;;;;
;;;;; deamon-impure
;;;;;
(defgeneric create-deamon-impure (deamon impure &key editor)
  (:method ((deamon-id integer) (impure-id integer) &key editor)
    (create-deamon-impure :deamon (get-deamon :id deamon-id)
                          :impure (get-impure :id impure-id)
                          :editor editor))
  (:method ((deamon rs_deamon) (impure rs_impure) &key editor)
    (assert (and deamon impure))
    (let ((editor-id (object-id editor)))
      (mito:create-dao 'th_deamon-impure
                       :deamon-id (object-id deamon)
                       :impure-id (object-id impure)
                       :created-by editor-id
                       :updated-by editor-id))))
