(in-package :holy-water.api.controller)

;;;;;
;;;;; make angel
;;;;;
(defun make-angel (&key name ghost-id creator)
  (assert (and name ghost-id creator))
  (dbi:with-transaction mito:*connection*
    (let ((angel        (hw::create-angel :name name :creator creator))
          (ghost-shadow (hw::make-ghost-shadow ghost-id :creator creator)))
      (hw::make-ghost-shadow_angel ghost-shadow angel :creator creator))))

;;;;;
;;;;; auth
;;;;;
(defun save-session (session-key angel)
  (let ((session caveman2:*session*))
    (setf (gethash session-key session)
          (list :id (mito:object-id angel)))))

(defun sing-in (email passowrd session-key)
  (let ((angel (hw:get-angel-at-auth email passowrd)))
    (unless angel (error "認証に失敗しました。"))
    (save-session session-key angel)))

(defun sing-out (session-key)
  (remhash session-key caveman2:*session*))

(defun ensure-ghost-shadow (ghost-id &key creator)
  (or (hw::get-ghost-shadow :ghost-id ghost-id)
      (hw::make-ghost-shadow ghost-id :creator creator)))

(defun ensure-ghost-angel (ghost name &key creator)
  (or (hw::ghost-angel :ghost ghost)
      (let ((angel (hw::create-angel :name name :creator creator)))
        (hw::make-ghost-shadow_angel ghost angel :creator creator)
        angel)))

(defun sing-up-by-ghost (id name &key creator)
  (dao2angel
   (ensure-ghost-angel (ensure-ghost-shadow id :creator creator)
                       name
                       :creator creator)))


;;;;;
;;;;;
;;;;;
(defclass angel ()
  ((id            :accessor id            :initform :null)
   (name          :accessor name          :initform :null)
   (ghost-id      :accessor ghost-id      :initform :null)))

(defmethod %to-json ((obj angel))
  (with-object
    (write-key-value "id"            (slot-value obj 'id))
    (write-key-value "name"          (slot-value obj 'name))
    (write-key-value "ghost_id"      (slot-value obj 'ghost-id))))

(defun dao2angel (dao)
  (when dao
    (let ((angel (make-instance 'angel))
          (ghost (hw::get-ghost-shadow :angel dao)))
      (setf (id angel)   (mito:object-id dao))
      (setf (name angel) (hw::name dao))
      (when ghost
        (setf (ghost-id angel) (hw::ghost-id ghost)))
      angel)))

(defun find-angels (angel)
  (mapcar #'dao2angel
          (hw:find-angels :without-angel angel)))

(defun get-angels (&key id)
  (hw:get-angel :id id))

(defun get-angel (&key ghost-id)
  (let ((angel (hw::ghost-angel :ghost-id ghost-id)))
    (if angel
        (dao2angel angel)
        :null)))


;;;;;
;;;;; request message
;;;;;
(defun angel-received-messages (angel)
  (hw::angel-received-messages angel))
