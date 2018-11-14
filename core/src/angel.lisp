(in-package :holy-water)

(defgeneric ensure-initial-maledict (angel &key creator)
  (:method ((angel rs_angel) &key creator)
    (dolist (maledict-type (find-initial-maledict-types))
      (create-angel-maledict angel
                             (apply #'create-maledict :creator creator maledict-type)
                             :creator creator))))


(defun create-angel (&key (name "????????") creator)
  (let ((by-id (creator-id creator)))
    (ensure-initial-maledict (mito:create-dao 'rs_angel
                                              :name name
                                              :created-by by-id
                                              :updated-by by-id)
                             :creator creator)))

(defgeneric find-maledicts (angel)
  (:method ((angel rs_angel))
    (mapcar #'(lambda (d)
                (mito:find-dao 'rs_maledict :id (maledict-id d)))
            (mito:select-dao 'th_angel-maledict
              (sxql:where (:= :angel-id (mito:object-id angel)))))))

(defgeneric get-inbox-maledict (angel)
  (:method ((angel rs_angel))
    (or (find-if #'(lambda (maledict)
                  (= *maledict-type-inbox* (maledict-type-id maledict)))
              (find-maledicts angel))
        (error "Not found InBox"))))
