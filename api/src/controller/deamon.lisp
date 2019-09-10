(in-package :holy-water.api.controller)

(defclass deamon ()
  ((id            :accessor id          :initform :null)
   (name          :accessor name        :initform :null)
   (name-short    :accessor name-short  :initform :null)
   (description   :accessor description :initform :null)
   (purged-at     :accessor purged-at   :initform :null)))

(defmethod %to-json ((obj deamon))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "name"        (slot-value obj 'name))
    (write-key-value "name_short"  (slot-value obj 'name-short))
    (write-key-value "description" (slot-value obj 'description))
    (write-key-value "purged_at"   (or (slot-value obj 'purged-at) :null))))

(defun dao2deamon (dao)
  (when dao
    (let ((deamon (make-instance 'deamon)))
      (setf (id deamon)          (mito:object-id dao))
      (setf (name deamon)        (hw::name dao))
      (setf (name-short deamon)  (hw::name-short dao))
      (setf (description deamon) (hw::description dao))
      (setf (purged-at deamon)   (hw::purged-at dao))
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

(defun update-deamon-description (angel deamon &key description)
  (declare (ignore angel))
  (assert deamon)
  (assert description)
  (setf (hw::description deamon) description)
  (mito:save-dao deamon)
  (dao2deamon deamon))

(defun update-deamon-name (angel deamon &key name)
  (declare (ignore angel))
  (assert deamon)
  (assert name)
  (setf (hw::name deamon) name)
  (mito:save-dao deamon)
  (dao2deamon deamon))

(defun puge-deamon (angel deamon)
  (assert deamon)
  (hw:purge-deamon deamon :editor angel)
  (dao2deamon deamon))
