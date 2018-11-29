(in-package :holy-water.api.controller)

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

;;;;;
;;;;;
;;;;;
(defclass angel ()
  ((id            :accessor id            :initform :null)
   (name          :accessor name          :initform :null)))

(defmethod %to-json ((obj angel))
  (with-object
    (write-key-value "id"            (slot-value obj 'id))
    (write-key-value "name"          (slot-value obj 'name))))

(defun dao2angel (dao)
  (when dao
    (let ((angel (make-instance 'angel)))
      (setf (id angel)            (mito:object-id dao))
      (setf (name angel)          (hw::name dao))
      angel)))

(defun find-angels (angel)
  (declare (ignore angel))
  (mapcar #'dao2angel
          (hw:find-angels)))
