(in-package :cl-user)
(defpackage holy-water.api.utililties
  (:use #:cl
        #:caveman2)
  (:export #:post-data
           #:get-session-key
           #:get-auth-angel
           #:with-angel))
(in-package :holy-water.api.utililties)

(defun post-data (_parsed)
  (jojo:parse (caar _parsed)))

(defun get-session-key ()
  (let ((cookie (caveman2:request-cookies caveman2:*request*)))
    (cdr (assoc "lack.session" cookie :test 'string=))))

(defun get-auth-angel ()
  (let* ((session-key (get-session-key))
         (session caveman2:*session*)
         (session-data (gethash session-key session)))
    (unless session-data (throw-code 401))
    (or (hw:get-angel :id (getf session-data :id))
        (throw-code 401))))

(defmacro with-angel ((angel) &body body)
  `(progn
     (let ((,angel (get-auth-angel)))
       ,@body)))
