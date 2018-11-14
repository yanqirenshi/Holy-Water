(in-package :holy-water)

(defgeneric create-angel-maledict (owner maledict &key creator)
  (:method ((owner rs_angel) (maledict rs_maledict) &key creator)
    (let ((by-id (creator-id creator)))
      (mito:create-dao 'th_angel-maledict
                       :angel-id (mito:object-id owner)
                       :maledict-id (mito:object-id maledict)
                       :created-by by-id
                       :updated-by by-id))))
