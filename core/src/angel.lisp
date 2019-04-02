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
