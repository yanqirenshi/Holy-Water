(in-package :holy-water)


;;;;;
;;;;; みどく Message list
;;;;;
(defun list-request-messages-unred-sql (angel table &key impure)
  (select (:ev_request.id
           :ev_request.impure_id
           :ev_request.requested_at
           (:as :ev_request.angel_id_from           :angel_from_id)
           (:as :rs_angel_from.name                 :angel_from_name)
           (:as :ev_request.angel_id_to             :angel_to_id)
           (:as :rs_angel_to.name                   :angel_to_name)
           (:as :ev_request_message_unread.id       :message_id)
           (:as :ev_request_message_unread.contents :message_contents)
           (:as :ev_request.impure_id               :impure_id)
           (:as :rs_impure.name                     :impure_name)
           (:as :rs_impure.description              :impure_description)
           (:as :rs_deamon.id                       :deamon_id)
           (:as :rs_deamon.name                     :deamon_name)
           (:as :rs_deamon.name_short               :deamon_name_short)
           (:as "REQUEST-MESSAGE"                   :_class))
    (from :ev_request)
    (inner-join :ev_request_message_unread
                :on (:= :ev_request.id :ev_request_message_unread.request_id))
    (inner-join (:as table :rs_impure)
                :on (:= :ev_request.impure_id :rs_impure.id))
    (left-join (:as :rs_angel :rs_angel_from)
               :on (:= :ev_request.angel_id_from :rs_angel_from.id))
    (left-join (:as :rs_angel :rs_angel_to)
               :on (:= :ev_request.angel_id_to :rs_angel_to.id))
    (left-join :th_deamon_impure
               :on (:= :rs_impure.id :th_deamon_impure.impure_id))
    (left-join :rs_deamon
               :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
    (if impure
        (where (:and (:= :ev_request.angel_id_to (mito:object-id angel))
                     (:= :ev_request.impure_id   (mito:object-id impure))))
        (where (:= :ev_request.angel_id_to (mito:object-id angel))))))

(defun list-request-messages-unred-infrate! (rec)
  (timestamptz2timestamp! rec :|requested_at|))

(defun list-request-messages-unred (angel &key impure)
  (nconc
   (fetch-all-list (list-request-messages-unred-sql angel :rs_impure_active    :impure impure)
                   :infrate! #'list-request-messages-unred-infrate!)
   (fetch-all-list (list-request-messages-unred-sql angel :rs_impure_finished  :impure impure)
                   :infrate! #'list-request-messages-unred-infrate!)
   (fetch-all-list (list-request-messages-unred-sql angel :rs_impure_discarded :impure impure)
                   :infrate! #'list-request-messages-unred-infrate!)))
