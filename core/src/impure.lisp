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
  (find-dao 'rs_impure-active :id id))

(defun make-impure-finished (impure &key editor)
  (let ((by-id (creator-id editor)))
    (make-instance 'rs_impure-finished
                   :id          (object-id impure)
                   :name        (name impure)
                   :description (description impure)
                   :finished-at (local-time:now)
                   :created-by  by-id
                   :updated-by  by-id)))

(defun impure-purge-now-p (angel impure)
  (get-purge :angel angel :impure impure))

(defun get-impure-purging (angel)
  (car (select-dao 'rs_impure-active
         (inner-join :ev_purge-start
                     :on (:= :rs_impure-active.id :ev_purge-start.impure-id))
         (where (:= :ev_purge-start.angel-id (object-id angel))))))
