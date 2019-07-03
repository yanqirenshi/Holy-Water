(in-package :holy-water.api.controller)

(defclass deamon ()
  ((id            :accessor id            :initform :null)
   (name          :accessor name          :initform :null)
   (name-short    :accessor name-short    :initform :null)
   (description   :accessor description   :initform :null)))

(defmethod %to-json ((obj deamon))
  (with-object
    (write-key-value "id"            (slot-value obj 'id))
    (write-key-value "name"          (slot-value obj 'name))
    (write-key-value "name_short"    (slot-value obj 'name-short))
    (write-key-value "description"   (slot-value obj 'description))))

(defun dao2deamon (dao)
  (when dao
    (let ((deamon (make-instance 'deamon)))
      (setf (id deamon)          (mito:object-id dao))
      (setf (name deamon)        (hw::name dao))
      (setf (name-short deamon)  (hw::name-short dao))
      (setf (description deamon) (hw::description dao))
      deamon)))

(defun find-deamons ()
  (mapcar #'dao2deamon
          (hw:find-deamons)))

(defun get-deamon (&key id)
  (when id
    (dao2deamon (mito:find-dao 'hw::rs_deamon :id id))))

(defun create-deamon (angel name name_short &key description)
  (assert (eq 1 (mito:object-id angel)))
  (dao2deamon (hw:create-deamon name name_short :description description :creator angel)))
