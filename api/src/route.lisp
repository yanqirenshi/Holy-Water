(in-package :cl-user)
(defpackage holy-water.api.route
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:holy-water.api.render)
  (:export #:*route*))
(in-package :holy-water.api.route)

;;;;;
;;;;; Router
;;;;;
(defclass <router> (<app>) ())
(defvar *route* (make-instance '<router>))
(clear-routing-rules *route*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "")

(defroute "/maledicts" ()
  (render-json (hw.api.ctrl:find-maledicts)))

(defroute "/maledicts/:id/impures" (&key id)
  (let ((maledict (hw:get-maledict :id id)))
    (unless maledict (throw-code 404))
    (render-json (hw.api.ctrl:find-impures :maledict maledict))))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
