(in-package :cl-user)
(defpackage holy-water.api.route
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:holy-water.api.render)
  (:export #:*route*))
(in-package :holy-water.api.route)


;;;;;
;;;;; utils
;;;;;
(defun get-angel ()
  (hw:get-angel :id 1))

(defun post-data (_parsed)
  (jojo:parse (caar _parsed)))

;;;;;
;;;;; Router
;;;;;
(defclass <router> (<app>) ())
(defvar *route* (make-instance '<router>))
(clear-routing-rules *route*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" () "")

;;;;;
;;;;; Maledict
;;;;;
(defroute "/maledicts" ()
  (render-json (hw.api.ctrl:find-maledicts)))


(defroute "/maledicts/:id/impures" (&key id)
  (let ((angel (get-angel))
        (maledict (hw:get-maledict :id id)))
    (unless maledict (throw-code 404))
    (render-json (hw.api.ctrl:find-impures angel :maledict maledict))))


(defroute ("/maledicts/:id/impures" :method :POST) (&key id _parsed)
  (let* ((angel (get-angel))
         (maledict (hw:get-maledict :id id))
         (post-data (post-data _parsed))
         (name (getf post-data :|name|))
         (description (getf post-data :|description|)))
    (unless maledict (throw-code 404))
    (hw.api.ctrl:create-impure-2-maledict maledict
                                          :name name
                                          :description description
                                          :editor angel)
    (render-json (hw.api.ctrl:find-impures angel :maledict maledict))))

(defroute ("/maledicts/:id/impures/move" :method :POST) (&key id _parsed)
  (let* ((angel (get-angel))
         (maledict (hw:get-maledict :id id))
         (post-data (post-data _parsed))
         (impure-id (getf post-data :|id|))
         (impure    (hw::get-impure :id impure-id)))
    (unless maledict (throw-code 404))
    (unless impure   (throw-code 404))
    (render-json (hw.api.ctrl:move-impure angel impure maledict))))


;;;;;
;;;;; Impure
;;;;;
(defroute ("/impures/:id/purges/start" :method :POST) (&key id)
  (let* ((angel (get-angel))
         (impure (hw::get-impure :id id)))
    (unless impure (throw-code 404))
    (render-json (hw.api.ctrl:start-action-4-impure angel impure))))

(defroute ("/impures/:id/purges/stop" :method :POST) (&key id)
  (let* ((angel (get-angel))
         (impure (hw::get-impure :id id)))
    (unless impure (throw-code 404))
    (render-json (hw.api.ctrl:stop-action-4-impure angel impure))))

(defroute ("/impures/:id/finish" :method :POST) (&key id)
  (let* ((angel (get-angel))
         (impure (hw::get-impure :id id)))
    (unless impure (throw-code 404))
    (render-json (hw.api.ctrl:finish-impure angel impure))))


;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
