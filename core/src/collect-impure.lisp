(in-package :holy-water)

(defgeneric collect-impure-create (maledict impure &key creator)
  (:method ((maledict rs_maledict) (impure rs_impure-active) &key creator)
    (let ((by-id (creator-id creator)))
      (create-dao 'ev_collect-impure
                  :maledict-id (object-id maledict)
                  :impure-id (object-id impure)
                  :created-by by-id
                  :updated-by by-id))))

(defgeneric collect-impure-move (impure from to &key creator)
  (:method ((impure rs_impure-active) (from rs_maledict) (to rs_maledict)&key creator)
    (list impure from to creator)))

(defun make-collect-impure (&key editor maledict impure collect-impure)
  (when (and maledict impure collect-impure)
    (let ((by-id (creator-id editor)))
      (make-instance 'ev_collect-impure-history
                     :id          (object-id collect-impure)
                     :maledict-id (object-id maledict)
                     :impure-id   (object-id impure)
                     :created-by  by-id
                     :updated-by  by-id))))


(defun create-collect-impure-history (collect-impure &key editor)
  (let ((by-id (creator-id editor)))
    (create-dao 'ev_collect-impure-history
                :maledict-id (maledict-id collect-impure)
                :impure-id   (impure-id collect-impure)
                :start       (start collect-impure)
                :created-by  by-id
                :updated-by  by-id)))


(defun get-collect-impure (&key angel impure)
  (when (and angel impure)
    (car (select-dao 'ev_collect-impure
           (sxql:inner-join :th_angel_maledict
                            :on (:=
                                 :ev_collect-impure.maledict-id
                                 :th_angel_maledict.maledict-id))
           (sxql:where (:and (:= :ev_collect-impure.impure-id
                                 (object-id impure))
                             (:= :th_angel_maledict.angel-id
                                 (object-id angel))))))))
