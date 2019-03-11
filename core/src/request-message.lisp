(in-package :holy-water)

(defun create-request-message (impure angel-from angel-to message)
  (mito:create-dao 'ev_request-message
                   :impure-id     (mito:object-id impure)
                   :angel-id-from (mito:object-id angel-from)
                   :angel-id-to   (mito:object-id angel-to)
                   :contents      message
                   :messaged-at   (local-time:now)))

;; (defun find-impure-request-messages (impure)
;;   (when impure
;;     (mito:retrieve-by-sql
;;      (select (
;;               :ev_request_message.angel_id_from
;;               (:as :rs_angel_from.name :angel_name_from)
;;               :ev_request_message.angel_id_to
;;               (:as :rs_angel_to.name :angel_name_to)
;;               :ev_request_message.contents
;;               :ev_request_message.messaged_at
;;               )
;;        (from :ev_request_message)
;;        (inner-join (:as :rs_angel :rs_angel_from) :on (:= :ev_request_message.angel_id_from :rs_angel_from.id))
;;        (inner-join (:as :rs_angel :rs_angel_to)   :on (:= :ev_request_message.angel_id_to   :rs_angel_to.id))
;;        (where (:= :ev_request_message.impure_id (mito:object-id impure)))))))
