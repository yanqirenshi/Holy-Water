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
;;;;; holy-water
;;;;;
(defroute "/holy-water" ()
  (with-angel (angel)
    (render-json (list :maleditds (hw.api.ctrl:find-maledicts angel)
                       :deamons   (hw.api.ctrl:find-deamons)
                       :orthodoxs (hw.api.ctrl:find-orthodoxs)))))


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

(defroute ("/maledicts/:id/impures" :method :POST) (&key id |name| |description|)
  (with-angel (angel)
    (let* ((maledict (hw:get-maledict :id id))
           (name (quri:url-decode |name|))
           (description (quri:url-decode |description|)))
      (unless maledict (throw-code 404))
      (hw.api.ctrl:create-impure-2-maledict maledict
                                            :name name
                                            :description description
                                            :editor angel)
      (render-json (hw.api.ctrl:find-impures angel :maledict maledict)))))

(defroute ("/maledicts/:id/impures/move" :method :POST) (&key id |id|)
  (with-angel (angel)
    (let* ((maledict (hw:get-maledict :id id))
           (impure-id (parse-integer |id|))
           (impure    (hw::get-impure :id impure-id)))
      (unless maledict (throw-code 404))
      (unless impure   (throw-code 404))
      (render-json (hw.api.ctrl:move-impure angel impure maledict)))))

;;;;;
;;;;; Deamons
;;;;;
(defroute "/deamons" ()
  (with-angel (angel)
    (declare (ignore angel))
    (render-json (hw.api.ctrl:find-deamons))))


;;;;;
;;;;; Orthodoxs
;;;;;
(defroute "/orthodoxs" ()
  (with-angel (angel)
    (declare (ignore angel))
    (render-json (hw.api.ctrl:find-orthodoxs))))


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

(defroute ("/impures/:id/finish" :method :POST) (&key id |with-stop|)
  (with-angel (angel)
    (let ((impure (hw::get-impure :id id)))
      (unless impure (throw-code 404))
      (render-json (hw.api.ctrl:finish-impure angel impure :with-stop |with-stop|)))))

(defroute ("/impures/:id" :method :POST) (&key id |name| |description|)
  (with-angel (angel)
    (let* ((name (quri:url-decode |name|))
           (description (quri:url-decode |description|))
           (impure (hw::get-impure :id id)))
      (unless impure (throw-code 404))
      (render-json (hw.api.ctrl:save-impure angel impure :name name :description description :editor angel)))))

(defroute "/impures/status/done" (&key |from| |to|)
  (with-angel (angel)
    (let ((from (local-time:parse-timestring |from|))
          (to   (local-time:parse-timestring |to|)))
    (render-json (hw.api.ctrl:find-impures-cemetery angel :from from :to to)))))

(defroute "/impures/purging" ()
  (with-angel (angel)
    (render-json (hw.api.ctrl:get-impure-purging angel))))


(defroute ("/impures/:impure-id/transfer/angel/:angel-id" :method :post) (&key impure-id angel-id |message|)
  (with-angel (angel)
    (let ((message (quri:url-decode (or |message| "")))
          (impure   (hw::get-impure         :id impure-id))
          (to-angel (hw.api.ctrl:get-angels :id angel-id)))
      (unless impure   (throw-code 404))
      (unless to-angel (throw-code 404))
      (render-json (hw.api.ctrl:transfer-impure angel to-angel impure message)))))

;;;;;
;;;;; Purge
;;;;;
(defroute "/purges/history" (&key |from| |to|)
  (with-angel (angel)
    (let ((from (local-time:parse-timestring |from|))
          (to   (local-time:parse-timestring |to|)))
      (render-json (hw.api.ctrl:find-purge-history angel :from from :to to)))))

(defroute ("/purges/:id/term" :method :POST) (&key id |start| |end|)
  (with-angel (angel)
    (let* ((start (local-time:parse-timestring |start|))
           (end   (local-time:parse-timestring |end|))
           (purge (hw::get-purge :id (parse-integer id) :status :all)))
      (unless purge (throw-code 404))
      (render-json (hw.api.ctrl:save-purge-term angel purge start end :editor angel)))))


;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
