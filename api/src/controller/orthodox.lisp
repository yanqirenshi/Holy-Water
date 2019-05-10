(in-package :holy-water.api.controller)

(defclass orthodox ()
  ((id          :accessor id          :initform :null)
   (name        :accessor name        :initform :null)
   (description :accessor description :initform :null)))

(defmethod %to-json ((obj orthodox))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "name"        (slot-value obj 'name))
    (write-key-value "description" (slot-value obj 'description))))

(defun dao2orthodox (dao)
  (when dao
    (let ((orthodox (make-instance 'orthodox)))
      (setf (id orthodox)          (mito:object-id dao))
      (setf (name orthodox)        (hw::name dao))
      (setf (description orthodox) (hw::description dao))
      orthodox)))

(defun find-orthodoxs ()
  (mapcar #'dao2orthodox
          (hw:find-orthodoxs)))

(defun get-orthodox (&key id)
  (when id
    (dao2orthodox (mito:find-dao 'hw::rs_orthodox :id id))))

(defun find-orthodox-all-exorcists ()
  (find-angels nil))

(defun find-orthodox-exorcists (&key orthodox-id)
  (mapcar #'dao2angel (hw::orthodox-angels orthodox-id)))

(defun angel-orthodox (angel)
  (dao2orthodox
   (hw:get-orthodox :angel angel)))

(defun pages-orthodox (orthodox &key angel)
  (declare (ignore angel))
  (list :|orthodox| (dao2orthodox orthodox)
        :|primate|  :null ;; 首座主教。 オーナー
        :|paladin|  nil   ;; かんりしゃけんげんをもつ。
        :|angels|   nil))

(defun pages-wor-history (angel start end)
  (when (and angel start end)
    (list :|summary|
          (list :|deamons| (hw:list-summay-purge-time-by-date-damon :angel angel
                                                                    :start start
                                                                    :end   end)))))

(defun pages-purges (angel from to)
  (when (and angel from to)
    (list :|purges| (hw:list-purge-by-angel angel :from from :to to))))
