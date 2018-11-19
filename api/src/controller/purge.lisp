(in-package :holy-water.api.controller)

(defclass purge ()
  ((id          :accessor id          :initform :null)
   (angel-id    :accessor angel-id    :initform :null)
   (impure-id   :accessor impure-id   :initform :null)
   (start       :accessor start       :initform :null)
   (description :accessor description :initform :null)))

(defun timestamp2str (ts)
  (if ts
      (local-time:format-timestring nil ts)
      :null))

(defmethod %to-json ((obj purge))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "angel-id"    (slot-value obj 'angel-id))
    (write-key-value "impure-id"   (slot-value obj 'impure-id))
    (write-key-value "start"       (timestamp2str (slot-value obj 'start)))
    (write-key-value "description" (slot-value obj 'description))))

(defun dao2purge (dao)
  (let ((purge (make-instance 'purge)))
    (setf (id purge)          (mito:object-id dao))
    (setf (angel-id  purge)   (hw::angel-id  dao))
    (setf (impure-id purge)   (hw::impure-id dao))
    (setf (start purge)       (hw::start dao))
    (setf (description purge) (hw::description dao))
    purge))
