(in-package :holy-water)

(defun create-request-message (impure angel-from angel-to message)
  (mito:create-dao 'ev_request-message-unread
                   :impure-id     (mito:object-id impure)
                   :angel-id-from (mito:object-id angel-from)
                   :angel-id-to   (mito:object-id angel-to)
                   :contents      message
                   :messaged-at   (local-time:now)))

(defun angel-received-messages (angel)
  (select-dao 'ev_request-message-unread
    (where (:= :ev_request_message_unread.angel_id_to (mito:object-id angel)))))
