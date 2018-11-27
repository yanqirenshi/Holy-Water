(in-package :holy-water.api.controller)

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
