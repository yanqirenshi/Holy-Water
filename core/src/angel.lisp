(in-package :holy-water)

(defun create-angel (angel &key (name "????????"))
  (let ((by (if angel (mito:object-id angel) 0)))
    (mito:create-dao 'rs-angel
                     :name name
                     :created-by by
                     :updated-by by)))
