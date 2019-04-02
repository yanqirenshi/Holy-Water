(in-package :holy-water)

(defun get-orthodox (&key id)
  (when id
    (find-dao 'rs_orthodox :id id)))

(defun find-orthodoxs ()
  (select-dao 'rs_orthodox))

(defgeneric make-orthodox-angel (orthodox angel &key creator)
  (:method ((orthodox rs_orthodox) (angel rs_angel) &key creator)
    (let ((orthodox-id (mito:object-id orthodox))
          (angel-id    (mito:object-id angel)))
      (or (find-dao 'th_orthodox_angel
                    :orthodox-id orthodox-id
                    :angel-id    angel-id)
          (create-dao 'th_orthodox_angel
                      :orthodox-id orthodox-id
                      :angel-id    angel-id
                      :created-by  (if creator (mito:object-id creator) nil)
                      :updated-by  (if creator (mito:object-id creator) nil)))))))
