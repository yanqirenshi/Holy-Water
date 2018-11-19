(in-package :holy-water)

(defgeneric collect-impure-create (maledict impure &key creator)
  (:method ((maledict rs_maledict) (impure rs_impure-active) &key creator)
    (let ((by-id (creator-id creator)))
      (mito:create-dao 'ev_collect-impure
                       :maledict-id (mito:object-id maledict)
                       :impure-id (mito:object-id impure)
                       :created-by by-id
                       :updated-by by-id))))

(defgeneric collect-impure-move (impure from to &key creator)
  (:method ((impure rs_impure-active) (from rs_maledict) (to rs_maledict)&key creator)
    (list impure from to creator)))
