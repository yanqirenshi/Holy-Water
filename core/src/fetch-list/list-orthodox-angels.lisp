(in-package :holy-water)


;;;;;
;;;;;
;;;;;
(defun list-orthodox-angels-sql (&key orthodox)
  (select (:rs_angel.id
           :rs_angel.name
           (:as :rs_orthodox_duty.id     :orthodox_duty_id)
           (:as :rs_orthodox_duty.name   :orthodox_duty_name)
           (:as :rs_orthodox_duty.description   :orthodox_duty_description)
           (:as :th_orthodox_angel.appointed_at :orthodox_angel_appointed_at)
           (:as :rs_orthodox.id          :orthodox_id)
           (:as :rs_orthodox.name        :orthodox_name)
           (:as :rs_orthodox.description :orthodox_description))
    (from :th_orthodox_angel)
    (inner-join :rs_angel
                :on (:= :th_orthodox_angel.angel_id :rs_angel.id))
    (left-join  :rs_orthodox
                :on (:= :th_orthodox_angel.orthodox_id :rs_orthodox.id))
    (left-join  :rs_orthodox_duty
                :on (:= :th_orthodox_angel.orthodox_duty_id :rs_orthodox_duty.id))
    (where (:= :th_orthodox_angel.orthodox_id (mito:object-id orthodox)))))

(defun list-orthodox-angels-infrate! (rec)
  (timestamptz2timestamp! rec :|appointed_at|))

(defun list-orthodox-angels (&key orthodox)
  (fetch-all-list (list-orthodox-angels-sql :orthodox orthodox)
                  :infrate! #'list-orthodox-angels-infrate!))
