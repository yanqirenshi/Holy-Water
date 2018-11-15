(in-package :holy-water)

(defvar *maledict-type-inbox* 1)

(defvar *maledict-types*
  (alexandria:alist-hash-table
   `((,*maledict-type-inbox* . (:name "In Box"         :order 0   :deletable 0 :description ""))
     (2                      . (:name "Next Action"    :order 10  :deletable 1 :description ""))
     (3                      . (:name "Plan Project"   :order 40  :deletable 1 :description ""))
     (4                      . (:name "Someday/Maybe"  :order 50  :deletable 1 :description ""))
     (5                      . (:name "Done"           :order 999 :deletable 0 :description ""))
     (0                      . (:name "????????"       :order 100 :deletable 1 :description "")))))

(defun %find-initial-maledict-types (&key (maledict-types *maledict-types*))
  (mapcar #'(lambda (d)
              (append (list :maledict-type-id (car d)) (cdr d)))
          (remove-if #'(lambda (d) (= 0 (car d)))
                     (alexandria:hash-table-alist maledict-types))))

(defun find-initial-maledict-types ()
  (sort (%find-initial-maledict-types)
        #'(lambda (a b) (< (getf a :order) (getf b :order)))))
