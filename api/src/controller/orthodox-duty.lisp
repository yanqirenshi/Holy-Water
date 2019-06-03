(in-package :holy-water.api.controller)

(defclass orthodox-duty ()
  ((id          :accessor id          :initform :null)
   (name        :accessor name        :initform :null)
   (description :accessor description :initform :null)))

(defmethod %to-json ((obj orthodox-duty))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "name"        (slot-value obj 'name))
    (write-key-value "description" (slot-value obj 'description))))

(defun dao2orthodox-duty (dao)
  (when dao
    (let ((orthodox-duty (make-instance 'orthodox-duty)))
      (setf (id orthodox-duty)          (mito:object-id dao))
      (setf (name orthodox-duty)        (hw::name dao))
      (setf (description orthodox-duty) (hw::description dao))
      orthodox-duty)))

(defun find-orthodox-duties ()
  (mapcar #'dao2orthodox-duty
          (hw:find-orthodox-duties)))
