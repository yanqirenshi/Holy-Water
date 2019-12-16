(in-package :holy-water)

(defun get-maledict (&key id angel)
  (cond ((and id angel)
         (first (remove-if #'(lambda (maledict)
                               (/= (mito:object-id maledict) id))
                           (find-maledicts :angel angel))))
        (id (find-dao 'rs_maledict :id id))))

(defun find-maledicts (&key angel)
  (select-dao 'rs_maledict
    (inner-join :th_angel-maledict :on (:= :rs_maledict.id :th_angel-maledict.maledict-id))
    (where (:= :th_angel-maledict.angel-id (object-id angel)))))

(defun get-maledict-type (&key maledict)
  (gethash (maledict-type-id maledict) *maledict-types*))

(defun create-maledict (&key creator
                          maledict-type-id
                          (name "????????")
                          (order 1)
                          (deletable nil)
                          (description ""))
  (let ((by-id (if creator (creator-id creator) -1)))
    (create-dao 'rs_maledict
                     :maledict-type-id maledict-type-id
                     :name name
                     :description description
                     :order order
                     :deletable deletable
                     :created-by by-id
                     :updated-by by-id)))


(defun get-maledict-done (&key angel)
  (when angel
    (car (select-dao 'rs_maledict
           (inner-join :th_angel_maledict
                       :on (:= :rs_maledict.id :th_angel_maledict.maledict-id))
           (where (:and (:= :th_angel_maledict.angel-id
                            (object-id angel))
                        (:= :rs_maledict.maledict-type-id
                            *maledict-type-done*)))))))
