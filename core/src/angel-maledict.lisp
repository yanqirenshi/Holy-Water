(in-package :holy-water)

(defgeneric create-angel-maledict (owner maledict &key creator)
  (:method ((owner rs_angel) (maledict rs_maledict) &key creator)
    (let ((by-id (if creator (creator-id creator) -1)))
      (create-dao 'th_angel-maledict
                  :angel-id (object-id owner)
                  :maledict-id (object-id maledict)
                  :created-by by-id
                  :updated-by by-id))))
