(in-package :holy-water)

(defun create-impure (&key creator
                          (name "????????")
                          (description ""))
  (let ((by-id (creator-id creator)))
    (mito:create-dao 'rs_impure-active
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
                (print (hw::impure-id d))
                (mito:find-dao 'hw::rs_impure-active :id (hw::impure-id d)))
            (mito:select-dao 'ev_collect-impure
              (sxql:where (:= :maledict-id (mito:object-id maledict)))))))

(defun find-impures-target (maledict)
  (if (= *maledict-type-done* (maledict-type-id maledict))
      '(:class rs_impure-finished :id-column :rs_impure-finished.id)
      '(:class rs_impure-active   :id-column :rs_impure-active.id)))

(defun find-impures (&key maledict)
  (when maledict
    (let ((target (find-impures-target maledict)))
      (mito:select-dao (getf target :class)
        (sxql:inner-join :ev_collect-impure
                         :on (:= (getf target :id-column) :ev_collect-impure.impure-id))
        (sxql:where (:= :ev_collect-impure.maledict-id (mito:object-id maledict)))))))


(defun get-impure (&key id)
  (mito:find-dao 'rs_impure-active :id id))

(defun make-impure-finished (impure &key editor)
  (let ((by-id (creator-id editor)))
    (make-instance 'rs_impure-finished
                   :id          (mito:object-id impure)
                   :name        (name impure)
                   :description (description impure)
                   :finished-at (local-time:now)
                   :created-by  by-id
                   :updated-by  by-id)))

(defun impure-purge-now-p (angel impure)
  (get-purge :angel angel :impure impure))
