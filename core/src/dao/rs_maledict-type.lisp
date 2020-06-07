(in-package :holy-water)

(defvar *maledict-type-inbox*         1)
(defvar *maledict-type-nex-action*    2)
(defvar *maledict-type-plan-project*  3)
(defvar *maledict-type-someday-maybe* 4)
(defvar *maledict-type-done*          5)
(defvar *maledict-type-user-create*   0)

(defvar *maledict-types*
  (alexandria:alist-hash-table
   `((,*maledict-type-inbox*         . (:maledict-type-id ,*maledict-type-inbox*         :name "In Box"         :order 0   :deletable 0 :description ""))
     (,*maledict-type-nex-action*    . (:maledict-type-id ,*maledict-type-nex-action*    :name "Next Action"    :order 10  :deletable 1 :description ""))
     (,*maledict-type-plan-project*  . (:maledict-type-id ,*maledict-type-plan-project*  :name "Plan Project"   :order 40  :deletable 1 :description ""))
     (,*maledict-type-someday-maybe* . (:maledict-type-id ,*maledict-type-someday-maybe* :name "Someday/Maybe"  :order 50  :deletable 1 :description ""))
     (,*maledict-type-done*          . (:maledict-type-id ,*maledict-type-done*          :name "Done"           :order 999 :deletable 0 :description ""))
     (,*maledict-type-user-create*   . (:maledict-type-id ,*maledict-type-user-create*   :name "????????"       :order 100 :deletable 1 :description ""))
     (,*maledict-type-user-create*   . (:maledict-type-id ,*maledict-type-user-create*   :name "Regular work"   :order 100 :deletable 1 :description "日々の繰返し実施している作業")))))

(defun %find-initial-maledict-types (&key (maledict-types *maledict-types*))
  (mapcar #'(lambda (d)
              (append (list :maledict-type-id (car d)) (cdr d)))
          (remove-if #'(lambda (d) (= 0 (car d)))
                     (alexandria:hash-table-alist maledict-types))))

(defun find-initial-maledict-types ()
  (sort (%find-initial-maledict-types)
        #'(lambda (a b) (< (getf a :order) (getf b :order)))))
