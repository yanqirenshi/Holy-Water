(in-package :holy-water.api.controller)

;;;;;
;;;;; purge
;;;;;
(defclass purge ()
  ((id          :accessor id          :initform :null)
   (angel-id    :accessor angel-id    :initform :null)
   (impure-id   :accessor impure-id   :initform :null)
   (start       :accessor start       :initform :null)
   (description :accessor description :initform :null)))


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


;;;;;
;;;;; purge-history
;;;;;
(defclass purge-history (purge)
  ((end         :accessor end         :initform :null)
   (impure-name :accessor impure-name :initform :null)))

(defun plist2purge-history (plist)
  (let ((purge (make-instance 'purge-history)))
    (setf (id purge)          (getf plist :|id|))
    (setf (angel-id  purge)   (getf plist :|angel_id|))
    (setf (impure-id purge)   (getf plist :|impure_id|))
    (setf (impure-name purge) (getf plist :|impure_name|))
    (setf (start purge)       (ut2timestamp (getf plist :|start|)))
    (setf (end   purge)       (ut2timestamp (getf plist :|end|)))
    (setf (description purge) (getf plist :|description|))
    purge))

(defmethod %to-json ((obj purge-history))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "angel_id"    (slot-value obj 'angel-id))
    (write-key-value "impure_id"   (slot-value obj 'impure-id))
    (write-key-value "impure_name" (slot-value obj 'impure-name))
    (write-key-value "start"       (timestamp2str (slot-value obj 'start)))
    (write-key-value "end"         (timestamp2str (slot-value obj 'end)))
    (write-key-value "description" (slot-value obj 'description))))

(defun find-purge-history (angel &key from to)
  (mapcar #'plist2purge-history
          (hw:find-purge-history :angel angel
                                 :from from
                                 :to to)))

(defun save-purge-term (angel purge start end &key editor)
  (dao2purge (hw:save-purge-term angel purge start end :editor editor)))
