(in-package :holy-water.api.controller)

(defclass maledict ()
  ((id            :accessor id            :initform :null)
   (name          :accessor name          :initform :null)
   (description   :accessor description   :initform :null)
   (order         :accessor order         :initform :null)
   (deletable     :accessor deletable     :initform :null)
   (maledict-type :accessor maledict-type :initform :null)))

(defmethod %to-json ((obj maledict))
  (with-object
    (write-key-value "id"            (slot-value obj 'id))
    (write-key-value "name"          (slot-value obj 'name))
    (write-key-value "description"   (slot-value obj 'description))
    (write-key-value "order"         (slot-value obj 'order))
    (write-key-value "deletable"     (slot-value obj 'deletable))
    (write-key-value "maledict-type" (slot-value obj 'maledict-type))))

(defun dao2maledict (dao)
  (when dao
    (let ((maledict (make-instance 'maledict)))
      (setf (id maledict)            (mito:object-id dao))
      (setf (name maledict)          (hw::name dao))
      (setf (description maledict)   (hw::description dao))
      (setf (order maledict)         (hw::order dao))
      (setf (deletable maledict)     (hw::deletable dao))
      (setf (maledict-type maledict) (hw:get-maledict-type :maledict dao))
      maledict)))

(defun find-maledicts ()
  (mapcar #'dao2maledict
          (hw:find-maledicts)))

(defun get-maledict (&key id)
  (when id
    (dao2maledict (mito:find-dao 'hw::rs_maledict :id id))))
