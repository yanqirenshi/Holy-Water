(in-package :holy-water.api.controller)

(defclass impure ()
  ((id            :accessor id            :initform :null)
   (name          :accessor name          :initform :null)
   (description   :accessor description   :initform :null)
   (purge         :accessor purge         :initform :null)))

(defmethod %to-json ((obj impure))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "name"        (slot-value obj 'name))
    (write-key-value "description" (slot-value obj 'description))
    (write-key-value "purge"       (slot-value obj 'purge))))

(defun dao2impure (dao &key angel)
  (let ((impure (make-instance 'impure)))
    (setf (id impure)            (mito:object-id dao))
    (setf (name impure)          (hw::name dao))
    (setf (description impure)   (hw::description dao))
    (when angel
      (let ((purge (hw:get-purge :angel angel :impure dao :status :start)))
        (setf (purge impure)
              (if purge (dao2purge purge) :null))))
    impure))

(defun find-impures (angel &key maledict)
  (let ((list (hw:find-impures :maledict maledict)))
    (mapcar #'(lambda (dao)
                (dao2impure dao :angel angel))
            list)))


(defun create-impure-2-maledict (maledict &key (name "????????") (description "") editor)
  (hw:add-impure maledict
                 (hw:create-impure :name name
                                   :description description
                                   :creator editor)
                 :creator editor))

(defun start-action-4-impure (angel impure)
  (dao2impure (hw:start-action-impure angel impure :editor angel)
              :angel angel))

(defun stop-action-4-impure (angel impure)
  (dao2impure (hw:stop-action-impure angel impure :editor angel)
              :angel angel))

(defun finish-impure (angel impure)
  (dao2impure (hw::finish-impure angel impure :editor angel)
              :angel angel))
