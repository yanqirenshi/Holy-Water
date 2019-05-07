(in-package :holy-water)


(defgeneric create-incantation-solo (impure angel spell &key creator)
  (:method ((impure rs_impure) (angel rs_angel) (spell string) &key creator)
    (let ((by-id (creator-id creator)))
      (create-dao 'ev_incantation-solo
                  :impure-id   (mito:object-id impure)
                  :angel-id    (mito:object-id angel)
                  :incantation-at (local-time:now)
                  :spell spell
                  :created-by  by-id
                  :updated-by  by-id))))


(defgeneric create-incantation-duet (impure angel-ena angel-duo spell &key creator)
  (:method ((impure rs_impure) (angel-ena rs_angel) (angel-duo rs_angel) (spell string) &key creator)
    (let ((by-id (creator-id creator)))
      (create-dao 'ev_incantation-solo
                  :impure-id    (mito:object-id impure)
                  :angel-id-ena (mito:object-id angel-ena)
                  :angel-id-duo (mito:object-id angel-duo)
                  :incantation-at (local-time:now)
                  :spell        spell
                  :created-by   by-id
                  :updated-by   by-id))))
