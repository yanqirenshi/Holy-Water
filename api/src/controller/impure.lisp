(in-package :holy-water.api.controller)

(defclass impure ()
  ((id            :accessor id            :initform :null)
   (name          :accessor name          :initform :null)
   (description   :accessor description   :initform :null)))

(defmethod %to-json ((obj impure))
  (with-object
    (write-key-value "id"            (slot-value obj 'id))
    (write-key-value "name"          (slot-value obj 'name))
    (write-key-value "description"   (slot-value obj 'description))))

(defun dao2impure (dao)
  (print dao)
  (let ((impure (make-instance 'impure)))
    (setf (id impure)            (mito:object-id dao))
    (setf (name impure)          (hw::name dao))
    (setf (description impure)   (hw::description dao))
    impure))

(defun find-impures (&key maledict)
  (mapcar #'dao2impure
          (hw:find-impures :maledict maledict)))


(defun create-impure-2-maledict (maledict &key (name "????????") (description "") editor)
  (hw:add-impure maledict
                 (hw:create-impure :name name
                                   :description description
                                   :creator editor)
                 :creator editor))
