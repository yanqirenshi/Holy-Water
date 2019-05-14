(in-package :holy-water)

(defun create-impure (&key creator
                        (name "????????")
                        (description ""))
  (let ((by-id (creator-id creator)))
    (create-dao 'rs_impure-active
                :name name
                :description description
                :created-by by-id
                :updated-by by-id)))


(defgeneric add-impure (target impure &key creator)

  (:method ((maledict rs_maledict) (impure rs_impure-active) &key creator)
    (collect-impure-create maledict impure :creator creator))

  (:method ((angel rs_angel) (impure rs_impure-active) &key creator)
    (let ((inbox (get-inbox-maledict angel)))
      (add-impure inbox impure :creator creator))))


(defgeneric add-after-impure (angel impure &key creator name description)
  (:method ((angel rs_angel) (impure rs_impure) &key creator name description)
    (let ((in-box (hw::get-inbox-maledict angel)))
      (assert in-box)
      (dbi:with-transaction mito:*connection*
        (let ((after-impure (create-impure :name name
                                           :description description
                                           :creator creator)))
          (add-impure in-box after-impure :creator creator)
          (mito:create-dao 're_impure
                           :id-from (mito:object-id impure)
                           :id-to   (mito:object-id after-impure))
          after-impure)))))


(defun find-impures (&key maledict)
  (when maledict
    (mapcar #'(lambda (d)
                (find-dao 'hw::rs_impure-active :id (hw::impure-id d)))
            (select-dao 'ev_collect-impure
              (sxql:where (:= :maledict-id (object-id maledict)))))))


(defun find-impures-target (maledict)
  (if (= *maledict-type-done* (maledict-type-id maledict))
      '(:class rs_impure-finished :id-column :rs_impure-finished.id)
      '(:class rs_impure-active   :id-column :rs_impure-active.id)))


(defun find-impures (&key maledict)
  (when maledict
    (let ((target (find-impures-target maledict)))
      (select-dao (getf target :class)
        (sxql:inner-join :ev_collect-impure
                         :on (:= (getf target :id-column) :ev_collect-impure.impure-id))
        (sxql:where (:= :ev_collect-impure.maledict-id (object-id maledict)))))))


(defun find-impures-cemetery-sql (maledict from to)
  (when maledict
    (select ((:as :rs_impure_finished.id   :id)
             (:as :rs_impure_finished.name :name)
             (:as :rs_impure_finished.description :description)
             (:as :rs_impure_finished.finished_at :finished_at)
             (:as (:min :ev_purge_end.start) :start)
             (:as (:max :ev_purge_end.end)   :end))
      (from :rs_impure_finished)
      (inner-join :ev_collect_impure
                  :on (:= :rs_impure_finished.id :ev_collect_impure.impure_id))
      (inner-join :ev_purge_end
                  :on (:= :ev_collect_impure.impure_id :ev_purge_end.impure_id))
      (where (:and (:= :ev_collect_impure.maledict_id (object-id maledict))
                   (:>= :rs_impure_finished.finished_at from)
                   (:<= :rs_impure_finished.finished_at to)))
      (sxql:group-by :rs_impure_finished.id))))

(defun find-impures-cemetery (angel &key from to)
  (let ((maledict (hw:get-maledict-done :angel angel)))
    (multiple-value-bind (sql vals)
        (sxql:yield (find-impures-cemetery-sql maledict from to))
      (dbi:fetch-all (apply #'dbi:execute (dbi:prepare mito:*connection* sql) vals)))))

(defun get-impure (&key id)
  (or (find-dao 'rs_impure-active :id id)
      (find-dao 'rs_impure-finished :id id)
      (find-dao 'rs_impure-discarded :id id)))

(defun make-impure-finished (impure &key editor)
  (let ((by-id (creator-id editor)))
    (make-instance 'rs_impure-finished
                   :id          (object-id impure)
                   :name        (name impure)
                   :description (description impure)
                   :finished-at (local-time:now)
                   :finished-by by-id
                   :created-at  (mito:object-created-at impure)
                   :created-by  (created-by impure)
                   :updated-by  by-id)))


(defun impure-purge-now-p (angel impure)
  (get-purge :angel angel :impure impure))


(defun get-impure-purging (angel)
  (car (select-dao 'rs_impure-active
         (inner-join :ev_purge-start
                     :on (:= :rs_impure-active.id :ev_purge-start.impure-id))
         (where (:= :ev_purge-start.angel-id (object-id angel))))))

(defun impure-set-deamon (angel impure deamon &key editor)
  (assert (angel-impure angel :id (mito:object-id angel)))
  (let* ((impure-id (mito:object-id impure))
         (deamon-id (mito:object-id deamon))
         (editor-id (mito:object-id editor))
         (deamon-impure (find-dao 'th_deamon-impure :impure-id impure-id)))
    (if deamon-impure
        (progn
          (setf (deamon-id  deamon-impure) deamon-id)
          (setf (updated-by deamon-impure) editor-id)
          (mito:save-dao deamon-impure))
        (progn
          (mito:create-dao 'th_deamon-impure
                           :deamon-id deamon-id
                           :impure-id impure-id
                           :created-by editor-id
                           :updated-by editor-id)))))
