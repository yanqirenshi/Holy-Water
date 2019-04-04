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

(defun angel-request-message (angel &key type from-or-to)
  (let ((dao-class (cond ((eq type :unread) 'ev_request-message-unread)
                         ((eq type :read)   'ev_request-message-read)))
        (angel-id-col (cond ((eq from-or-to :from) :angel-id-from)
                         ((eq from-or-to :to)   :angel-id-to))))
    (when (and dao-class angel-id-col)
      (first (select-dao dao-class
               (where (:= angel-id-col (mito:object-id angel))))))))

(defgeneric read-request-message (angel request-message-unread)
  (:method ((angel rs_angel) (unread ev_request-message-unread))
    (assert (angel-request-message angel :type :unread :from-or-to :to))
    (let ((readed (make-instance 'ev_request-message-read
                                 :impure-id     (impure-id unread)
                                 :angel-id-from (angel-id-from unread)
                                 :angel-id-to   (angel-id-to unread)
                                 :contents      (contents unread)
                                 :messaged-at   (messaged-at unread)
                                 :readed-at     (local-time:now)
                                 :created-by    (created-by unread)
                                 :created-at    (mito:object-created-at unread)
                                 :updated-by    (updated-by unread)
                                 :updated-at    (local-time:now))))
      (mito:delete-dao unread)
      (mito:insert-dao readed))))


(defun get-request-message (&key type id)
  (let ((dao-class (cond ((eq type :unread) 'ev_request-message-unread)
                         ((eq type :read)   'ev_request-message-read))))
    (when dao-class
      (find-dao dao-class :id id))))
