(in-package :holy-water)

(defun get-angel-at-ghost-shadow-id (ghost-id)
  (car (select-dao 'rs_angel
         (inner-join :th_ghost-shadow_angel
                     :on (:= :rs_angel.id :th_ghost-shadow_angel.angel-id))
         (inner-join :rs_ghost-shadow
                     :on (:= :th_ghost-shadow_angel.ghost-shadow-id  :rs_ghost-shadow.id))
         (where (:= :rs_ghost-shadow.ghost-id ghost-id)))))

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
