(in-package :holy-water)

;;;;;
;;;;; purge-start
;;;;;
(defun get-purge-start (&key id angel impure)
  (cond (id (find-dao 'ev_purge-start :id id))
        ((and angel impure)
         (find-dao 'ev_purge-start
                   :angel-id  (object-id angel)
                   :impure-id (object-id impure)))
        ((and angel (null impure))
         (find-dao 'ev_purge-start
                   :angel-id  (object-id angel)))))

(defun get-purge-end (&key id angel impure)
  (cond (id (find-dao 'ev_purge-end :id id))
        ((and angel impure)
         (find-dao 'ev_purge-end
                   :angel-id  (object-id angel)
                   :impure-id (object-id impure)))))


(defun get-purge (&key id angel impure (status :start))
  (cond ((eq :start status)
         (if impure
             (get-purge-start :id id :angel angel :impure impure)
             (get-purge-start :id id :angel angel)))
        ((eq :end status)
         (get-purge-end :id id :angel angel :impure impure))
        ((eq :all status)
         (or (get-purge :id id :angel angel :impure impure :status :start)
             (get-purge :id id :angel angel :impure impure :status :end)))
        (t (error "bad status. status=~S" status))))

(defun get-purge-started (&key angel)
  (select-dao 'ev_purge-start
    (where (:= :ev_purge-start.angel-id (object-id angel)))))

(defun create-purge-start (angel impure &key editor description (start (local-time:now)))
  (let ((by-id (creator-id editor)))
    (create-dao 'ev_purge-start
                :angel-id  (object-id angel)
                :impure-id (object-id impure)
                :start start
                :description (or description "")
                :created-by by-id
                :updated-by by-id)))


;;;;;
;;;;; purge-stop
;;;;;
(defun create-purge-end (angel purge-start &key editor (stop (local-time:now)))
  (declare (ignore angel))
  (let ((by-id (creator-id editor)))
    (create-dao 'ev_purge-end
                :id          (object-id         purge-start)
                :angel-id    (angel-id          purge-start)
                :impure-id   (impure-id         purge-start)
                :start       (start             purge-start)
                :end         stop
                :description (description       purge-start)
                :created-by  (created-by        purge-start)
                :updated-by  by-id
                :created-at  (object-updated-at purge-start)
                :updated-by  (object-updated-at purge-start))
    (delete-dao purge-start)))

;;;;;
;;;;; find purge hisotry
;;;;;
(defun find-purge-history-sql (angel table &key from to)
  (let* ((table-name (symbol-name table))
         (id-col   (alexandria:make-keyword (concatenate 'string table-name ".ID")))
         (name-col (alexandria:make-keyword (concatenate 'string table-name ".NAME"))))
    (select (:ev_purge_end.*
             (:as name-col :impure_name)
             (:as :rs_angel.name :angel_name))
      (from :ev_purge_end)
      (inner-join table
                  :on (:= :ev_purge_end.impure_id id-col))
      (left-join :rs_angel
                 :on (:= :ev_purge_end.angel_id :rs_angel.id))
      (where (:and (:= :ev_purge_end.angel_id (object-id angel))
                   (:or (:and (:<= :ev_purge_end.start from)
                              (:>= :ev_purge_end.end   from))
                        (:and (:>= :ev_purge_end.start from)
                              (:<  :ev_purge_end.start to))))))))


(defun find-purge-history-sql-at-impure (impure table)
  (let* ((table-name (symbol-name table))
         (id-col   (alexandria:make-keyword (concatenate 'string table-name ".ID")))
         (name-col (alexandria:make-keyword (concatenate 'string table-name ".NAME"))))
    (select (:ev_purge_end.*
             (:as name-col       :impure_name)
             (:as :rs_angel.name :angel_name))
      (from :ev_purge_end)
      (inner-join table
                  :on (:= :ev_purge_end.impure_id id-col))
      (left-join :rs_angel
                 :on (:= :ev_purge_end.angel_id :rs_angel.id))
      (where (:= :ev_purge_end.impure_id (object-id impure))))))


(defun find-purge-history (&key angel impure from to)
  (cond (angel
         (multiple-value-bind (sql vals)
             (sxql:yield
              (union-all-queries
               (find-purge-history-sql angel :rs_impure_active    :from from :to to)
               (find-purge-history-sql angel :rs_impure_finished  :from from :to to)
               (find-purge-history-sql angel :rs_impure_discarded :from from :to to)))
           (dbi:fetch-all (apply #'dbi:execute (dbi:prepare mito:*connection* sql) vals))))
        (impure
         (progn
           (multiple-value-bind (sql vals)
               (sxql:yield
                (union-all-queries
                 (find-purge-history-sql-at-impure impure :rs_impure_active)
                 (find-purge-history-sql-at-impure impure :rs_impure_finished)
                 (find-purge-history-sql-at-impure impure :rs_impure_discarded)))
             (dbi:fetch-all (apply #'dbi:execute (dbi:prepare mito:*connection* sql) vals)))))))


(defun save-purge-term (angel purge start end &key editor)
  (declare (ignore angel))
  ;; TODO: angel purge の関係をチェックする。
  (let ((by-id (creator-id editor)))
    (setf (start purge) start)
    (setf (end purge) end)
    (setf (updated-by purge) by-id)
    (save-dao purge)
    purge))
