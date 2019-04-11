(in-package :holy-water)

(defgeneric ensure-initial-maledict (angel &key creator)
  (:method ((angel rs_angel) &key creator)
    (dolist (maledict-type (find-initial-maledict-types))
      (create-angel-maledict angel
                             (apply #'create-maledict :creator creator maledict-type)
                             :creator creator))))


(defun create-angel (&key (name "????????") creator)
  (let ((by-id (creator-id creator)))
    (let ((angel (create-dao 'rs_angel
                             :name name
                             :created-by by-id
                             :updated-by by-id)))
      (ensure-initial-maledict angel :creator creator)
      angel)))

(defun find-angels (&key without-angel)
  (if without-angel
      (select-dao 'rs_angel (where (:!= :id (mito:object-id without-angel))))
      (select-dao 'rs_angel)))

(defun get-angel (&key id)
  (find-dao 'rs_angel :id id))


(defgeneric find-angel-maledicts (angel)
  (:method ((angel rs_angel))
    (mapcar #'(lambda (d)
                (find-dao 'rs_maledict :id (maledict-id d)))
            (select-dao 'th_angel-maledict
              (sxql:where (:= :angel-id (object-id angel)))))))


(defgeneric get-inbox-maledict (angel)
  (:method ((angel rs_angel))
    (or (find-if #'(lambda (maledict)
                     (= *maledict-type-inbox* (maledict-type-id maledict)))
                 (find-angel-maledicts angel))
        (error "Not found InBox"))))

(defun angel-impure-core (table angel id)
  (let ((id-col (cond ((eq table 'rs_impure-active)    :rs_impure_active.id)
                      ((eq table 'rs_impure-finished)  :rs_impure_finished.id)
                      ((eq table 'rs_impure-discarded) :rs_impure_discarded.id))))
    (first (select-dao table
             (inner-join :ev_collect_impure
                         :on (:= id-col :ev_collect_impure.impure_id))
             (inner-join :th_angel_maledict
                         :on (:= :ev_collect_impure.maledict_id :th_angel_maledict.maledict_id))
             (where (:and (:= :th_angel_maledict.angel_id (mito:object-id angel))
                          (:= :ev_collect_impure.impure_id id)))))))

(defgeneric angel-impure (angel &key id)
  (:method ((angel rs_angel) &key id)
    (when id
      (or (angel-impure-core 'rs_impure-active    angel id)
          (angel-impure-core 'rs_impure-finished  angel id)
          (angel-impure-core 'rs_impure-discarded angel id)))))
