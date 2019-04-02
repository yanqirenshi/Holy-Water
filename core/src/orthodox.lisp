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
                      :updated-by  (if creator (mito:object-id creator) nil))))))

(defgeneric orthodox-angels (orthodox)
  (:method ((orthodox rs_orthodox))
    (select-dao 'rs_angel
      (inner-join :th_orthodox_angel
                  :on (:= :rs_angel.id :th_orthodox_angel.angel_id))
      (where (:= :th_orthodox_angel.orthodox_id (mito:object-id orthodox)))))
  (:method ((orthodox-id integer))
    (let ((orthodox (get-orthodox :id orthodox-id)))
      (when orthodox
        (orthodox-angels orthodox)))))
