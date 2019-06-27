(in-package :holy-water)

(defun fetch-list (sql vals)
  (dbi:fetch-all (apply #'dbi:execute (dbi:prepare mito:*connection* sql) vals)))

;;;;;
;;;;; Summay Purge Time by Date-Damon
;;;;;
(defun list-summay-purge-time-by-date-damon-sql (angel start end)
  (multiple-value-bind (sql vals)
      (sxql:yield
       (select (:ev_purge_end.angel_id
                (:as (:to_char :ev_purge_end.start :@@@format-YYYY-MM-DD) :date)
                (:as (:max :rs_deamon.name) :deamon_name)
                (:as :rs_deamon.id :deamon_id)
                (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :elapsed_time))
         (from  :ev_purge_end)
         (left-join :th_deamon_impure
                    :on (:= :ev_purge_end.impure_id :th_deamon_impure.impure_id))
         (left-join :rs_deamon
                    :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
         (where (:and (:= :ev_purge_end.angel_id (mito:object-id angel))
                      (:>= :ev_purge_end.start start)
                      (:<  :ev_purge_end.start end)))
         (group-by :ev_purge_end.angel_id
                   (:to_char :ev_purge_end.start :@@@format-YYYY-MM-DD)
                   :rs_deamon.id)))
    (values (cl-ppcre:regex-replace-all "@@@format-yyyy-mm-dd" sql "'YYYY-MM-DD'")
            vals)))

(defun list-summay-purge-time-by-date-damon (&key angel start end)
  (multiple-value-bind (sql vals)
      (list-summay-purge-time-by-date-damon-sql angel start end)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|elapsed_time|)
              (second (assoc :seconds (getf rec :|elapsed_time|)))))
      results)))



;;;;;
;;;;; Angel ごと の Purge いちらん
;;;;;
(defun list-purge-by-angel-sql-template (table angel &key from to)
  (select ((:as :ev_purge_end.id          :purge_id)
           (:as :ev_purge_end.angel_id    :angel_id)
           (:as :ev_purge_end.impure_id   :impure_id)
           (:as :ev_purge_end.description :purge_description)
           (:as :ev_purge_end.start       :purge_start)
           (:as :ev_purge_end.end         :purge_end)
           (:as (:- :ev_purge_end.end :ev_purge_end.start) :elapsed_time)
           (:as :rs_impure.id             :impure_id)
           (:as :rs_impure.name           :impure_name)
           (:as :rs_impure.description    :impure_description)
           (:as :rs_deamon.id             :deamon_id)
           (:as :rs_deamon.name           :deamon_name)
           (:as :rs_deamon.name_short     :deamon_name_short))
    (from :ev_purge_end)
    (inner-join (:as table :rs_impure)
                :on (:= :ev_purge_end.impure_id :rs_impure.id))
    (left-join :th_deamon_impure
               :on (:= :rs_impure.id :th_deamon_impure.impure_id))
    (left-join :rs_deamon
               :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
    (where (:and (:= :ev_purge_end.angel_id (mito:object-id angel))
                 (:or (:and (:<= :ev_purge_end.start from)
                            (:>= :ev_purge_end.end   from))
                      (:and (:>= :ev_purge_end.start from)
                            (:<  :ev_purge_end.start to)))))))

(defun list-purge-by-angel-sql (angel &key from to)
  (sxql:yield
   (union-all-queries
    (list-purge-by-angel-sql-template :rs_impure_active   angel :from from :to to)
    (list-purge-by-angel-sql-template :rs_impure_finished angel :from from :to to))))

(defun list-purge-by-angel (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-purge-by-angel-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (timestamptz2timestamp! rec :|purge_start|)
        (timestamptz2timestamp! rec :|purge_end|)
        (interval2second!       rec :|elapsed_time|))
      results)))


;;;;;
;;;;; Impure ごとの Purge いちらん
;;;;;
(defun list-purge-by-impure-sql (impure table)
  (select ((:as :ev_purge_end.id          :purge_id)
           (:as :rs_angel.id              :angel_id)
           (:as :rs_angel.name            :angel_name)
           (:as :ev_purge_end.impure_id   :impure_id)
           (:as :ev_purge_end.description :purge_description)
           (:as :ev_purge_end.start       :purge_start)
           (:as :ev_purge_end.end         :purge_end)
           (:as (:- :ev_purge_end.end :ev_purge_end.start) :elapsed_time)
           (:as :rs_impure.id             :impure_id)
           (:as :rs_impure.name           :impure_name)
           (:as :rs_impure.description    :impure_description)
           (:as :rs_deamon.id             :deamon_id)
           (:as :rs_deamon.name           :deamon_name)
           (:as :rs_deamon.name_short     :deamon_name_short))
    (from :ev_purge_end)
    (inner-join (:as table :rs_impure)
                :on (:= :ev_purge_end.impure_id :rs_impure.id))
    (left-join :th_deamon_impure
               :on (:= :rs_impure.id :th_deamon_impure.impure_id))
    (left-join :rs_deamon
               :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
    (left-join :rs_angel
               :on (:= :ev_purge_end.angel_id :rs_angel.id))

    (where (:= :ev_purge_end.impure_id (mito:object-id impure)))))

(defun list-purge-by-impure-infrate! (rec)
  (timestamptz2timestamp! rec :|purge_start|)
  (timestamptz2timestamp! rec :|purge_end|)
  (interval2second!       rec :|elapsed_time|))

(defun list-purge-by-impure (impure)
  (nconc
   (fetch-all-list (list-purge-by-impure-sql impure :rs_impure_active)
                   :infrate! #'list-purge-by-impure-infrate!)
   (fetch-all-list (list-purge-by-impure-sql impure :rs_impure_finished)
                   :infrate! #'list-purge-by-impure-infrate!)))


;;;;;
;;;;; 墓標の日別/悪魔別の数
;;;;;
;; select to_char(finished_at, 'YYYY-MM-DD')
;;      , 0
;;      , 'TOTAL'
;;      , count(*)
;;   from rs_impure_finished
;;  where updated_by = 1
;;    and finished_at >= '2019-05-01'
;;    and finished_at <  '2019-05-10'
;; group by to_char(finished_at, 'YYYY-MM-DD')
(defun list-summay-impure-cemeteries-by-date-damon-sql (angel &key from to)
  (multiple-value-bind (sql vals)
      (sxql:yield
       (select ((:as (:to_char :rs_impure_finished.finished_at :@@@format-YYYY-MM-DD) :finished_at)
                (:as :th_deamon_impure.deamon_id  :deamon_id)
                (:as (:max :rs_deamon.name)       :deamon_name)
                (:as (:max :rs_deamon.name_short) :deamon_name_short)
                (:as (:count :*)                  :purge_count))
         (from :rs_impure_finished)
         (left-join :th_deamon_impure
                    :on (:= :rs_impure_finished.id :th_deamon_impure.impure_id))
         (left-join :rs_deamon
                    :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
         (where (:and (:=  :rs_impure_finished.finished_by (mito:object-id angel))
                      (:>= :rs_impure_finished.finished_at from)
                      (:<  :rs_impure_finished.finished_at to)))
         (group-by (:to_char :rs_impure_finished.finished_at :@@@format-YYYY-MM-DD)
                   :th_deamon_impure.deamon_id)))
    (values (cl-ppcre:regex-replace-all "@@@format-yyyy-mm-dd" sql "'YYYY-MM-DD'")
            vals)))

(defun list-summay-impure-cemeteries-by-date-damon (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-summay-impure-cemeteries-by-date-damon-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|elapsed_time|)
              (second (assoc :seconds (getf rec :|elapsed_time|)))))
      results)))

;;;;;
;;;;; List Cemeteries
;;;;;
(defun list-cemeteries-sql (angel &key from to)
  (sxql:yield
   (select ((:as :rs_impure_finished.id                 :impure_id)
            (:as (:max :rs_impure_finished.name)        :impure_name)
            (:as (:max :rs_impure_finished.description) :impure_description)
            (:as (:max :rs_impure_finished.finished_at) :impure_finished_at)
            (:as (:max :th_deamon_impure.deamon_id)     :deamon_id)
            (:as (:max :rs_deamon.name)                 :deamon_name)
            (:as (:max :rs_deamon.name_short)           :deamon_name_short)
            (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :elapsed_time)
            (:as (:count :ev_purge_end.id)              :purge_count))
     (from :rs_impure_finished)
     (left-join :th_deamon_impure
                :on (:= :rs_impure_finished.id :th_deamon_impure.impure_id))
     (left-join :rs_deamon
                :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (left-join :ev_purge_end
                :on (:= :rs_impure_finished.id :ev_purge_end.impure_id))
     (where (:and (:=  :rs_impure_finished.finished_by (mito:object-id angel))
                  (:>= :rs_impure_finished.finished_at from)
                  (:<  :rs_impure_finished.finished_at to)))
     (group-by :rs_impure_finished.id))))

(defun list-cemeteries (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-cemeteries-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|impure_finished_at|)
              (local-time:format-timestring nil (local-time:universal-to-timestamp (getf rec :|impure_finished_at|))))
        (setf (getf rec :|elapsed_time|)
              (if (eq :null (getf rec :|elapsed_time|))
                  0
                  (second (assoc :seconds (getf rec :|elapsed_time|))))))
      results)))

;;;;;
;;;;; List Summary Purge by Deamon
;;;;;
(defun list-summary-purge-by-deamon-sql (angel &key from to)
  (sxql:yield
   (select ((:as :th_deamon_impure.deamon_id  :deamon_id)
            (:as (:max :rs_deamon.name)       :deamon_name)
            (:as (:max :rs_deamon.name_short) :deamon_name_short)
            (:as (:count :*)                  :purge_count)
            (:as (:sum (:- :ev_purge_end.end :ev_purge_end.start)) :elapsed_time))
     (from :ev_purge_end)
     (left-join :th_deamon_impure
                :on (:= :ev_purge_end.impure_id :th_deamon_impure.impure_id))
     (left-join :rs_deamon
                :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (where (:and (:= :ev_purge_end.angel_id (mito:object-id angel))
                  (:or (:and (:<= :ev_purge_end.start from)
                             (:>= :ev_purge_end.end   from))
                       (:and (:>= :ev_purge_end.start from)
                             (:<  :ev_purge_end.start to)))))
     (group-by :th_deamon_impure.deamon_id))))

(defun list-summary-purge-by-deamon (angel &key from to)
  (multiple-value-bind (sql vals)
      (list-summary-purge-by-deamon-sql angel :from from :to to)
    (let ((results (fetch-list sql vals)))
      (dolist (rec results)
        (setf (getf rec :|elapsed_time|)
              (if (eq :null (getf rec :|elapsed_time|))
                  0
                  (second (assoc :seconds (getf rec :|elapsed_time|))))))
      results)))

;;;;;
;;;;; maledict impures
;;;;;
(defun list-maledict-impures-sql (angel maledict)
  (sxql:yield
   (select ((:as :ev_collect_impure.impure_id :id)
            :rs_impure.name
            :rs_impure.description
            (:as :ev_purge_start.id             :purge_id)
            (:as :ev_purge_start.start          :purge_started_at)
            (:as :th_deamon_impure.deamon_id    :deamon_id)
            (:as :rs_deamon.name                :deamon_name)
            (:as :rs_deamon.name_short          :deamon_name_short)
            (:as :ev_collect_impure.maledict_id :maledict_id)
            (:as :rs_maledict.name              :maledict_name)
            (:as :rs_maledict.description       :maledict_description)
            (:as :rs_maledict.order             :maledict_order)
            (:as :rs_maledict.deletable         :maledict_deletable)
            (:as "IMPURE"                       :_class))
     (from :th_angel_maledict)
     (left-join :ev_collect_impure
                :on (:= :th_angel_maledict.maledict_id :ev_collect_impure.maledict_id))
     (left-join (:as :rs_impure_active :rs_impure)
                :on (:= :ev_collect_impure.impure_id :rs_impure.id))
     (left-join :th_deamon_impure
                :on (:= :rs_impure.id :th_deamon_impure.impure_id))
     (left-join :rs_deamon
                :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
     (left-join :ev_purge_start
                :on (:= :ev_collect_impure.impure_id :ev_purge_start.impure_id))
     (left-join :rs_maledict
                :on (:= :th_angel_maledict.maledict_id :rs_maledict.id))
     (where (:and (:not-null :ev_collect_impure.impure_id)
                  (:= :th_angel_maledict.angel_id (mito:object-id angel))
                  (:= :th_angel_maledict.maledict_id (mito:object-id maledict)))))))

(defun list-maledict-impures (angel maledict)
  (when (and angel maledict)
    (multiple-value-bind (sql vals)
        (list-maledict-impures-sql angel maledict)
      (let ((results (fetch-list sql vals)))
        ;; TODO: なんかする？
        results))))


;;;;;
;;;;;
;;;;;
;; INNER JOIN ev_request_message_read
(defun list-requested-uncomplete-impures-sql (angel)
  (when angel
    (select  (:rs_impure.id
              :rs_impure.name
              :rs_impure.description

              (:as :ev_request.id :requested_id)
              (:as :ev_request.angel_id_to :angel_to_id)
              (:as :rs_angel_to.name :angel_to_name)
              (:as :ev_request.requested_at :requested_at)

              (:as :rs_deamon.id :deamon_id)
              (:as :rs_deamon.name :deamon_name)
              (:as :rs_deamon.name_short :deamon_name_short)

              (:as :rs_maledict.id :maledict_id)
              (:as :rs_maledict.name :maledict_name)
              (:as :rs_maledict.description :maledict_description)
              (:as "IMPURE_WAITING-FOR" :_class))
      (from (:as :rs_impure_active :rs_impure))
      (inner-join :ev_request
                  :on (:= :rs_impure.id :ev_request.impure_id))
      (left-join (:as :rs_angel :rs_angel_to)
                 :on (:= :ev_request.angel_id_to :rs_angel_to.id))
      (left-join :th_deamon_impure
                 :on (:= :th_deamon_impure.impure_id :rs_impure.id))
      (left-join :rs_deamon
                 :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
      (left-join :ev_collect_impure
                 :on (:= :rs_impure.id :ev_collect_impure.impure_id))
      (left-join :rs_maledict
                 :on (:= :ev_collect_impure.maledict_id :rs_maledict.id))
      (left-join :th_angel_maledict
                 :on (:= :rs_maledict.id :th_angel_maledict.maledict_id))
      (left-join (:as :rs_angel :rs_angel_now)
                 :on (:= :th_angel_maledict.angel_id :rs_angel_now.id))
      (where (:= :ev_request.angel_id_from (mito:object-id angel))))))

(defun list-requested-uncomplete-impures-infrate! (rec)
  (timestamptz2timestamp! rec :|requested_at|))

(defun list-requested-uncomplete-impures (angel)
  (fetch-all-list (list-requested-uncomplete-impures-sql angel)
                  :infrate! #'list-requested-uncomplete-impures-infrate!))


;;;;;
;;;;; みどく Message list
;;;;;
(defun list-request-messages-unred-sql (angel table &key impure)
  (select (:ev_request.id
           :ev_request.impure_id
           :ev_request.requested_at
           (:as :ev_request.angel_id_from           :angel_from_id)
           (:as :rs_angel_from.name                 :angel_from_name)
           (:as :ev_request.angel_id_to             :angel_to_id)
           (:as :rs_angel_to.name                   :angel_to_name)
           (:as :ev_request_message_unread.id       :message_id)
           (:as :ev_request_message_unread.contents :message_contents)
           (:as :ev_request.impure_id               :impure_id)
           (:as :rs_impure.name                     :impure_name)
           (:as :rs_impure.description              :impure_description)
           (:as :rs_deamon.id                       :deamon_id)
           (:as :rs_deamon.name                     :deamon_name)
           (:as :rs_deamon.name_short               :deamon_name_short)
           (:as "REQUEST-MESSAGE"                   :_class))
    (from :ev_request)
    (inner-join :ev_request_message_unread
                :on (:= :ev_request.id :ev_request_message_unread.request_id))
    (inner-join (:as table :rs_impure)
                :on (:= :ev_request.impure_id :rs_impure.id))
    (left-join (:as :rs_angel :rs_angel_from)
               :on (:= :ev_request.angel_id_from :rs_angel_from.id))
    (left-join (:as :rs_angel :rs_angel_to)
               :on (:= :ev_request.angel_id_to :rs_angel_to.id))
    (left-join :th_deamon_impure
               :on (:= :rs_impure.id :th_deamon_impure.impure_id))
    (left-join :rs_deamon
               :on (:= :th_deamon_impure.deamon_id :rs_deamon.id))
    (if impure
        (where (:and (:= :ev_request.angel_id_to (mito:object-id angel))
                     (:= :ev_request.impure_id   (mito:object-id impure))))
        (where (:= :ev_request.angel_id_to (mito:object-id angel))))))

(defun list-request-messages-unred-infrate! (rec)
  (timestamptz2timestamp! rec :|requested_at|))

(defun list-request-messages-unred (angel &key impure)
  (nconc
   (fetch-all-list (list-request-messages-unred-sql angel :rs_impure_active    :impure impure)
                   :infrate! #'list-request-messages-unred-infrate!)
   (fetch-all-list (list-request-messages-unred-sql angel :rs_impure_finished  :impure impure)
                   :infrate! #'list-request-messages-unred-infrate!)
   (fetch-all-list (list-request-messages-unred-sql angel :rs_impure_discarded :impure impure)
                   :infrate! #'list-request-messages-unred-infrate!)))

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
