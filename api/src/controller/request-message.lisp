(in-package :holy-water.api.controller)

(defclass request-message ()
  ((id            :accessor id            :initform :null)
   (impure-id     :accessor impure-id     :initform :null)
   (angel-id-from :accessor angel-id-from :initform :null)
   (angel-id-to   :accessor angel-id-to   :initform :null)
   (contents      :accessor contents      :initform :null)
   (messaged-at   :accessor messaged-at   :initform :null)
   (readed-at     :accessor readed-at     :initform :null)))

(defmethod %to-json ((obj request-message))
  (with-object
    (write-key-value "id"            (slot-value obj 'id))
    (write-key-value "impure_id"     (slot-value obj 'impure-id))
    (write-key-value "angel_id_from" (slot-value obj 'angel-id-from))
    (write-key-value "angel_id_to"   (slot-value obj 'angel-id-to))
    (write-key-value "contents"      (slot-value obj 'contents))
    (write-key-value "messaged_at"   (timestamp2str (slot-value obj 'messaged-at)))
    (write-key-value "readed_at"     (timestamp2str (slot-value obj 'readed-at)))))

(defgeneric dao2request-message-readed-at (dao)
  (:method ((dao hw::ev_request-message-unread))
    :null)
  (:method ((dao hw::ev_request-message-read))
    (hw::readed-at dao)))

(defun dao2request-message (dao)
  (when dao
    (let ((obj (make-instance 'request-message)))
      (setf (id obj)            (mito:object-id dao))
      (setf (impure-id obj)     (hw::impure-id dao))
      (setf (angel-id-from obj) (hw::angel-id-from dao))
      (setf (angel-id-to obj)   (hw::angel-id-to dao))
      (setf (contents obj)      (hw::contents dao))
      (setf (messaged-at obj)   (hw::messaged-at dao))
      (setf (readed-at obj)     (dao2request-message-readed-at dao))
      obj)))

;;;;;
;;;;; request message
;;;;;
(defun angel-received-messages (angel)
  (mapcar #'dao2request-message
          (hw::angel-received-messages angel)))

(defun change-to-read-request-message (angel request-message-unread)
  (dbi:with-transaction mito:*connection*
    (dao2request-message
     (hw::read-request-message angel request-message-unread))))

(defun request-messages (angel)
  (hw:list-request-messages-unred angel))

(defun pages-requests (angel)
  (list :|unread| (hw:list-request-messages-unred angel)))
