(in-package :holy-water)

(defun create-maledict (angel &key
                                 (name "????????")
                                 (order 1)
                                 (deletable nil))
  (let ((by (if angel (mito:object-id angel) 0)))
    (mito:create-dao 'rs_maledict
                     :name name
                     :order order
                     :deletable deletable
                     :created-by by
                     :updated-by by)))


(defgeneric add-new-maledict (creator owner &key name order deletable)
  (:method ((creator rs_angel) (owner rs_angel) &key (name "????????") (order 888888) (deletable nil))
    (create-angel-maledict creator
                         owner
                         (create-maledict creator :name name :order order :deletable deletable))))


(let ((angel (mito:find-dao 'rs_angel)))
  (add-new-maledict angel angel :name "InBox" :deletable t  :order 0))
