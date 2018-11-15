(in-package :holy-water)

(defun create-impure (&key creator
                          (name "????????")
                          (description ""))
  (let ((by-id (creator-id creator)))
    (mito:create-dao 'rs_impure
                     :name name
                     :description description
                     :created-by by-id
                     :updated-by by-id)))


(defgeneric add-impure (target impure &key creator)
  (:method ((maledict rs_maledict) (impure rs_impure) &key creator)
    (collect-impure-create maledict impure :creator creator))
  (:method ((angel rs_angel) (impure rs_impure) &key creator)
    (let ((inbox (get-inbox-maledict angel)))
      (add-impure inbox impure :creator creator))))

(defun find-impures (&key maledict)
  (when maledict
    (mapcar #'(lambda (d)
                (print (hw::impure-id d))
                (mito:find-dao 'hw::rs_impure :id (hw::impure-id d)))
            (mito:select-dao 'ev_collect-impure
              (sxql:where (:= :maledict-id (mito:object-id maledict)))))))

(defun find-impures (&key maledict)
  (when maledict
    (mapcar #'(lambda (d)
                ;; TODO: これはまずいよなぁ。
                (mito:find-dao 'rs_impure :id (impure-id d)))
            (mito:select-dao 'ev_collect-impure
              (sxql:where (:= :maledict-id (mito:object-id maledict)))))))
