(in-package :holy-water)

(defun list-relational-impures-by-impure-sql (from-table to-table direction &key impure)
  (let ((id_from (if (eq :before direction) :re_impure.id_to   :re_impure.id_from))
        (id_to   (if (eq :before direction) :re_impure.id_from :re_impure.id_to)))
    (select ((:as (symbol-name direction) :relationship_direction)
             (:as :re_impure.id           :relationship_id)
             (:as :re_impure.id_to        :relationship_id_to)
             (:as :re_impure.id_from      :relationship_id_from)
             :rs_impure.id
             :rs_impure.name
             :rs_impure.description
             (if (eq to-table :rs_impure_finished)  :rs_impure.finished_at  '(:as :null :finished_at))
             (if (eq to-table :rs_impure_finished)  :rs_impure.finished_by  '(:as :null :finished_by))
             (if (eq to-table :rs_impure_discarded) :rs_impure.discarded_at '(:as :null :discarded_at))
             (:as :rs_deamon.id         :deamon_id)
             (:as :rs_deamon.name       :deamon_name)
             (:as :rs_deamon.name_short :deamon_name_short)
             (:as :rs_maledict.id       :maledict_id)
             (:as :rs_maledict.name     :maledict_name)
             (:as :rs_angel.id          :angel_id)
             (:as :rs_angel.name        :angel_name))
      (from (:as from-table :rs_impure_source))
      (inner-join :re_impure
                  :on (:= :rs_impure_source.id id_from))
      (inner-join (:as to-table :rs_impure)
                  :on (:= id_to :rs_impure.id))
      (left-join :th_deamon_impure
                 :on (:= :rs_impure.id :th_deamon_impure.impure_id))
      (left-join :rs_deamon
                 :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
      (left-join :ev_collect_impure
                 :on (:= :rs_impure.id :ev_collect_impure.impure_id))
      (left-join :rs_maledict
                 :on (:= :ev_collect_impure.maledict_id :rs_maledict.id))
      (left-join :th_angel_maledict
                 :on (:= :rs_maledict.id :th_angel_maledict.maledict_id))
      (left-join :rs_angel
                 :on (:= :th_angel_maledict.angel_id :rs_angel.id))
      (where (:= :rs_impure_source.id (mito:object-id impure))))))


(defun list-relational-impures-by-impure-infrate! (rec)
  (timestamptz2timestamp! rec :|finished_at|)
  (timestamptz2timestamp! rec :|discarded_at|))


(defun list-relational-impures-by-impure-core-to-tables (impure from-table direction &optional (to-tables *tables-rs_impure*))
  (when-let ((to-table (car to-tables)))
    (nconc (fetch-all-list (list-relational-impures-by-impure-sql from-table
                                                                  to-table
                                                                  direction
                                                                  :impure impure)
                           :infrate! #'list-relational-impures-by-impure-infrate!)
           (list-relational-impures-by-impure-core-to-tables impure from-table direction (cdr to-tables)))))


(defun list-relational-impures-by-impure-directions (impure table &key (directions '(:before :after)))
  (when-let ((direction (car directions)))
    (nconc (list-relational-impures-by-impure-core-to-tables impure table direction)
           (list-relational-impures-by-impure-directions impure table :directions (cdr directions)))))


(defun list-relational-impures-by-impure (impure &key (tables *tables-rs_impure*))
  (when impure
    (when-let ((table (car tables)))
      (nconc (list-relational-impures-by-impure-directions impure table)
             (list-relational-impures-by-impure impure :tables (cdr tables))))))
