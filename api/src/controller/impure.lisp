(in-package :holy-water.api.controller)

(defclass impure ()
  ((id            :accessor id            :initarg :id          :initform :null)
   (name          :accessor name          :initarg :name        :initform :null)
   (description   :accessor description   :initarg :description :initform :null)
   (purge         :accessor purge         :initarg :purge       :initform :null)
   (finished-at   :accessor finished-at   :initarg :finished-at :initform :null)
   (start         :accessor start         :initarg :start       :initform :null)
   (end           :accessor end           :initarg :end         :initform :null)
   (_class        :accessor _class        :initarg :_class      :initform :null)))

(defmethod %to-json ((obj impure))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "name"        (slot-value obj 'name))
    (write-key-value "description" (slot-value obj 'description))
    (write-key-value "purge"       (or (slot-value obj 'purge) :null))
    (write-key-value "finished_at" (or (slot-value obj 'finished-at) :null))
    (write-key-value "start"       (or (slot-value obj 'start) :null))
    (write-key-value "end"         (or (slot-value obj 'end)   :null))
    (write-key-value "_class"      (or (slot-value obj '_class) :null))))

(defun dao2impure_class (dao)
  (or (symbol-name (class-name (class-of dao)))
      :null))

(defun dao2impure (dao &key angel)
  (when dao
    (let ((impure (make-instance 'impure)))
      (setf (id impure)            (mito:object-id dao))
      (setf (name impure)          (hw::name dao))
      (setf (description impure)   (hw::description dao))
      (setf (_class impure)        (dao2impure_class dao))
      (when angel
        (let ((purge (hw:get-purge :angel angel :impure dao :status :start)))
          (setf (purge impure)
                (if purge (dao2purge purge) :null))))
      impure)))

(defun find-impures (angel &key maledict)
  (let ((list (hw:find-impures :maledict maledict)))
    (mapcar #'(lambda (dao)
                (dao2impure dao :angel angel))
            list)))

(defun get-impure (angel &key id)
  (when (and angel id)
    (dao2impure (hw:angel-impure angel :id id))))

(defun get-impure-purging (angel)
  (let ((impure (hw::get-impure-purging angel)))
    (or (dao2impure impure :angel angel) :null)))

(defun create-impure-2-maledict (maledict &key (name "????????") (description "") editor)
  (hw:add-impure maledict
                 (hw:create-impure :name name
                                   :description description
                                   :creator editor)
                 :creator editor))

(defun start-action-4-impure (angel impure)
  (multiple-value-bind (impure stopped-impure)
      (hw:start-action-impure angel impure :editor angel)
    (list :|impure_started| (dao2impure impure :angel angel)
          :|impure_stopped| (or (dao2impure stopped-impure :angel angel)
                                :null))))

(defun stop-action-4-impure (angel impure)
  (dao2impure (hw:stop-action-impure angel impure :editor angel)
              :angel angel))

(defun finish-impure (angel impure &key with-stop)
  (dao2impure (hw::finish-impure angel impure
                                 :editor angel
                                 :with-stop with-stop)
              :angel angel))

(defun move-impure (angel impure maledict)
  (dao2impure (hw:move-impure angel impure maledict :editor angel)
              :angel angel))

(defun save-impure (angel impure &key name description editor)
  (dao2impure (hw:save-impure angel impure :name name :description description :editor editor)
              :angel angel))

(defun find-impures-cemetery (angel &key from to)
  (mapcar #'(lambda (plist)
              (make-instance 'impure
                             :id          (getf plist :|id|)
                             :name        (getf plist :|name|)
                             :description (getf plist :|description|)
                             :purge       (getf plist :|purge|)
                             :finished-at (timestamp2str (local-time:universal-to-timestamp (getf plist :|finished_at|)))
                             :start       (timestamp2str (local-time:universal-to-timestamp (getf plist :|start|)))
                             :end         (timestamp2str (local-time:universal-to-timestamp (getf plist :|end|)))))
          (hw:find-impures-cemetery angel :from from :to to)))

(defun transfer-impure (angel to-angel impure message)
  (let ((to-maledict (hw::get-inbox-maledict to-angel))
        (collected   (hw::get-collect-impure :angel angel :impure impure)))
    (unless collected   (caveman2:throw-code 404))
    (unless to-maledict (caveman2:throw-code 500))
    (when (hw::impure-purge-now-p angel impure)
      (caveman2:throw-code 500))
    (hw:create-request-message impure angel to-angel message)
    (hw.api.ctrl:move-impure angel impure to-maledict)))


(defun create-after-impure (angel impure &key name description)
  (hw:add-after-impure angel
                       impure
                       :name name
                       :description description
                       :creator angel))
