(in-package :cl-user)
(defpackage holy-water.api.route
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:holy-water.api.render
        #:holy-water.api.utililties)
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
(defroute "/" () "Hello Holy Water!")


;;;;;
;;;;; Angels
;;;;;
(defroute ("/sign/in" :method :POST) (&key |email| |password|)
  (let* ((email     |email|)
         (password  |password|))
    (when (hw.api.ctrl:sing-in email password (get-session-key))
      (render-json nil))))

(defroute ("/sign/out" :method :POST) ()
  (hw.api.ctrl:sing-out (get-session-key))
  (render-json nil))

(defroute "/angels" ()
  (with-angel (angel)
    (render-json (hw.api.ctrl:find-angels angel))))


;;;;;
;;;;; Maledict
;;;;;
(defroute "/maledicts" ()
  (with-angel (angel)
    (render-json (hw.api.ctrl:find-maledicts angel))))


(defroute "/maledicts/:id/impures" (&key id)
  (with-angel (angel)
    (let ((maledict (hw:get-maledict :id id)))
      (unless maledict (throw-code 404))
      (render-json (hw.api.ctrl:find-impures angel :maledict maledict)))))

(defroute ("/maledicts/:id/impures" :method :POST) (&key id _parsed)
  (with-angel (angel)
    (let* ((maledict (hw:get-maledict :id id))
           (post-data (post-data _parsed))
           (name (getf post-data :|name|))
           (description (getf post-data :|description|)))
      (unless maledict (throw-code 404))
      (hw.api.ctrl:create-impure-2-maledict maledict
                                            :name name
                                            :description description
                                            :editor angel)
      (render-json (hw.api.ctrl:find-impures angel :maledict maledict)))))

(defroute ("/maledicts/:id/impures/move" :method :POST) (&key id _parsed)
  (with-angel (angel)
    (let* ((maledict (hw:get-maledict :id id))
           (post-data (post-data _parsed))
           (impure-id (getf post-data :|id|))
           (impure    (hw::get-impure :id impure-id)))
      (unless maledict (throw-code 404))
      (unless impure   (throw-code 404))
      (render-json (hw.api.ctrl:move-impure angel impure maledict)))))


;;;;;
;;;;; Impure
;;;;;
(defroute ("/impures/:id/purges/start" :method :POST) (&key id)
  (with-angel (angel)
    (let ((impure (hw::get-impure :id id)))
      (unless impure (throw-code 404))
      (render-json (hw.api.ctrl:start-action-4-impure angel impure)))))

(defroute ("/impures/:id/purges/stop" :method :POST) (&key id)
  (with-angel (angel)
    (let ((impure (hw::get-impure :id id)))
      (unless impure (throw-code 404))
      (render-json (hw.api.ctrl:stop-action-4-impure angel impure)))))

(defroute ("/impures/:id/finish" :method :POST) (&key id)
  (with-angel (angel)
    (let ((impure (hw::get-impure :id id)))
      (unless impure (throw-code 404))
      (render-json (hw.api.ctrl:finish-impure angel impure)))))

(defroute ("/impures/:id" :method :POST) (&key id _parsed)
  (with-angel (angel)
    (let* ((post-data (post-data _parsed))
           (name (getf post-data :|name|))
           (description (getf post-data :|description|))
           (impure (hw::get-impure :id id)))
      (unless impure (throw-code 404))
      (render-json (hw.api.ctrl:save-impure angel impure :name name :description description :editor angel)))))

(defroute "/impures/status/done" (&key)
  (with-angel (angel)
    (let ((maledict (hw:get-maledict-done :angel angel)))
      (unless maledict (throw-code 404))
      (render-json (hw.api.ctrl:find-impures angel :maledict maledict)))))


;;;;;
;;;;; Purge
;;;;;
(defroute "/purges/history" (&key |from| |to|)
  (with-angel (angel)
    (let ((from (local-time:parse-timestring |from|))
          (to   (local-time:parse-timestring |to|)))
      (render-json (hw.api.ctrl:find-purge-history angel :from from :to to)))))

(defroute ("/purges/:id/term" :method :POST) (&key id _parsed)
  (with-angel (angel)
    (let* ((post-data (post-data _parsed))
           (start (local-time:parse-timestring (getf post-data :|start|)))
           (end   (local-time:parse-timestring (getf post-data :|end|)))
           (purge (hw::get-purge :id (parse-integer id) :status :all)))
      (unless purge (throw-code 404))
      (render-json (hw.api.ctrl:save-purge-term angel purge start end :editor angel)))))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
