(in-package :holy-water)

(defgeneric get-angel-at-auth (email password)
  (:method ((email string) (password string))
    (let ((auth (find-dao 'ev_setting-auth :email email :password password)))
      (when auth
        (get-angel :id (angel-id auth)))))
  (:documentation "email と password で認証し、rs_angel を返す"))

(defun create-setting-auth (angel &key email password editor)
  (let ((by-id (creator-id editor)))
    (create-dao 'ev_setting-auth
                :angel-id (object-id angel)
                :email email
                :password password
                :created-by by-id
                :updated-by by-id)))
