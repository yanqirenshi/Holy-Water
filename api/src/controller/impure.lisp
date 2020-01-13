(in-package :holy-water.api.controller)

(defclass impure ()
  ((id            :accessor id            :initarg :id          :initform :null)
   (name          :accessor name          :initarg :name        :initform :null)
   (description   :accessor description   :initarg :description :initform :null)
   (purge         :accessor purge         :initarg :purge       :initform :null)
   (finished-at   :accessor finished-at   :initarg :finished-at :initform :null)
   (start         :accessor start         :initarg :start       :initform :null)
   (end           :accessor end           :initarg :end         :initform :null)
   (purges        :accessor purges        :initarg :purges      :initform nil)
   (requests      :accessor requests      :initarg :requests    :initform nil)
   (_class        :accessor _class        :initarg :_class      :initform :null)))

(defmethod %to-json ((obj impure))
  (with-object
    (write-key-value "id"          (slot-value obj 'id))
    (write-key-value "name"        (slot-value obj 'name))
    (write-key-value "description" (slot-value obj 'description))
    (write-key-value "purge"       (or (slot-value obj 'purge)       :null))
    (write-key-value "finished_at" (or (timestamp2str (slot-value obj 'finished-at)) :null))
    (write-key-value "start"       (or (slot-value obj 'start)       :null))
    (write-key-value "end"         (or (slot-value obj 'end)         :null))
    (write-key-value "purges"      (slot-value obj 'purges))
    (write-key-value "requests"    (slot-value obj 'requests))
    (write-key-value "_class"      (or (slot-value obj '_class)      :null))))

(defun dao2impure_class (dao)
  (or (symbol-name (class-name (class-of dao)))
      :null))

(defgeneric dao2impure_finished-at (dao)
  (:method ((dao hw::rs_impure-finished))
    (hw::finished-at dao))
  (:method (dao)
    nil))


(defun dao2impure (dao &key angel with-details)
  (when dao
    (let ((impure (make-instance 'impure)))
      (setf (id impure)            (mito:object-id dao))
      (setf (name impure)          (hw::name dao))
      (setf (description impure)   (hw::description dao))
      (setf (finished-at impure)   (dao2impure_finished-at dao))
      (setf (_class impure)        (dao2impure_class dao))
      ;; purge
      (when angel
        (let ((purge (hw:get-purge :angel angel :impure dao :status :start)))
          (setf (purge impure)
                (if purge (dao2purge purge) :null))))
      (when with-details
        ;; TODO: 以下は core に実装すべきやね
        ;; purges
        (setf (purges impure)
              (mapcar #'plist2purge-history
                      (hw:find-purge-history :impure dao)))
        ;; requests
        (setf (requests impure)
              (mapcar #'dao2request-message
                      (nconc
                       (mito:select-dao 'hw::ev_request-message-unread
                         (sxql:where (:= :ev_request_message_unread.impure_id (mito:object-id dao))))
                       (mito:select-dao 'hw::ev_request-message-read
                         (sxql:where (:= :ev_request_message_read.impure_id (mito:object-id dao))))))))
      impure)))

(defun find-impures (angel &key maledict)
  (let ((list (hw:find-impures :maledict maledict)))
    (mapcar #'(lambda (dao)
                (dao2impure dao :angel angel))
            list)))

(defun get-impure (angel &key id)
  (when (and angel id)
    (let ((impure (hw:angel-impure angel :id id)))
      (dao2impure impure :with-details t))))

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

(defun empty-string-p (str)
  (and str (string/= "" (string-trim '(#\Space #\Tab #\Newline #\IDEOGRAPHIC_SPACE) str))))

(defun impure-incantation (angel impure spell)
  (when (empty-string-p spell)
    (hw:create-incantation-solo impure angel spell :creator angel)
    (dao2impure impure :angel angel)))

(defun finish-impure (angel impure &key with-stop spell)
  ;; TODO: dbi:with-transaction mito:*connection*
  (let ((impure-finished (hw::finish-impure angel impure
                                            :editor angel
                                            :with-stop with-stop)))
    (impure-incantation angel impure spell)
    (dao2impure impure-finished :angel angel)))

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
    (dbi:with-transaction mito:*connection*
      (when (hw::impure-purge-now-p angel impure)
        (hw:stop-action-impure angel impure :editor angel))
      (hw:create-request-message impure angel to-angel message
                                 (hw:create-request impure angel to-angel))
      (hw.api.ctrl:move-impure angel impure to-maledict))))


(defun create-after-impure (angel impure_before &key name description deamon-id)
  (dbi:with-transaction mito:*connection*
    (let ((deamon (hw::get-deamon :id deamon-id)))
      (when deamon-id
        (assert deamon))
      (dbi:with-transaction mito:*connection*
        (let ((impure (hw:add-after-impure angel
                                           impure_before
                                           :name name
                                           :description description
                                           :creator angel)))
          (when deamon
            (hw:impure-set-deamon angel impure deamon :editor angel))
          (dao2impure impure))))))

(defun create-deamon-impure (angel deamon &key name description)
  (assert (and  angel deamon))
  (dbi:with-transaction mito:*connection*
    (dao2impure
     (hw:add-deamon-impure angel
                           deamon
                           :name name
                           :description description
                           :creator angel))))

(defun impure-set-deamon (angel impure deamon-id)
  (let ((deamon (hw::get-deamon :id deamon-id)))
    (assert deamon)
    (hw:impure-set-deamon angel impure deamon :editor angel)))

(defun impure-set-deamon-new (angel deamon impure)
  "TODO: impure-set-deamon の新しいヤツ"
  (assert deamon)
  (assert impure)
  (hw:impure-set-deamon angel impure deamon :editor angel)
  (list :|deamon| (dao2deamon deamon)
        :|impure| (dao2impure (hw:get-impure :id (mito:object-id impure)))))


(defun update-impure-description (angel impure &key description)
  (declare (ignore angel))
  (assert impure)
  (assert description)
  (setf (hw::description impure) description)
  (mito:save-dao impure)
  (dao2impure impure))


;;;;;
;;;;; create-impure
;;;;;
(defun create-impure-core (angel name description maledict-id deamon-id)
  (let ((maledict (and maledict-id (hw:get-maledict :id maledict-id)))
        (deamon   (and deamon-id   (hw::get-deamon  :id deamon-id))))
    (when maledict-id (assert maledict))
    (when deamon-id   (assert deamon))
    (let ((new-impure (hw:create-impure :name name
                                        :description description
                                        :creator angel)))
      (if maledict
          (hw:add-impure maledict new-impure :creator angel)
          (hw:add-impure angel    new-impure :creator angel))
      (when deamon
        (hw:create-deamon-impure deamon new-impure :editor angel))

      (list :|deamon|   (or (dao2deamon deamon) :null)
            :|maledict| (dao2maledict (hw::impure-maledict new-impure))
            :|impure|   (dao2impure new-impure :angel angel)))))


(defun create-impure (angel &key name description maledict-id deamon-id)
  (dbi:with-transaction mito:*connection*
    (create-impure-core angel name description maledict-id deamon-id)))
