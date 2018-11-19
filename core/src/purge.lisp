(in-package :holy-water)

;;;;;
;;;;; purge-start
;;;;;
(defun get-purge-start (&key id angel impure)
  (cond (id (mito:find-dao 'ev_purge-start :id id))
        ((and angel impure)
         (mito:find-dao 'ev_purge-start
                        :angel-id  (mito:object-id angel)
                        :impure-id (mito:object-id impure)))))

(defun get-purge (&key id angel impure (status :start))
  (cond ((eq :start status )
         (get-purge-start :id id :angel angel :impure impure))
        ((eq :end status ) nil)
        (t (error "bad status. status=~S" status))))

(defun create-purge-start (angel impure &key editor description (start (local-time:now)))
  (let ((by-id (creator-id editor)))
    (mito:create-dao 'ev_purge-start
                     :angel-id  (mito:object-id angel)
                     :impure-id (mito:object-id impure)
                     :start start
                     :description (or description "")
                     :created-by by-id
                     :updated-by by-id)))

;;;;;
;;;;; purge-stop
;;;;;
(defun create-purge-end (angel purge-start &key editor (stop (local-time:now)))
  (declare (ignore angel))
  (let ((by-id (creator-id editor)))
    (mito:create-dao 'ev_purge-end
                     :id          (mito:object-id         purge-start)
                     :angel-id    (angel-id               purge-start)
                     :impure-id   (impure-id              purge-start)
                     :start       (start                  purge-start)
                     :end         stop
                     :description (description            purge-start)
                     :created-by  (created-by             purge-start)
                     :updated-by  by-id
                     :created-at  (mito:object-updated-at purge-start)
                     :updated-by  (mito:object-updated-at purge-start))
    (mito:delete-dao purge-start)))
