(in-package :holy-water.api.controller)

(defun pages-orthodox (orthodox &key angel)
  (declare (ignore angel))
  (list :|orthodox| (dao2orthodox orthodox)
        :|duties|   (find-orthodox-duties)
        :|angels|   (hw:list-orthodox-angels :orthodox orthodox)))


(defun pages-wor-history (angel start end)
  (when (and angel start end)
    (list :|summary|
          (list :|deamons| (hw:list-summay-purge-time-by-date-damon :angel angel
                                                                    :start start
                                                                    :end   end)))))


(defun pages-purges (angel from to)
  (when (and angel from to)
    (list :|purges| (hw:list-purge-by-angel angel :from from :to to)
          :|summary| (list :|deamons| (hw:list-summary-purge-by-deamon angel
                                                                       :from from
                                                                       :to   to)))))


(defun pages-cemetery (angel from to)
  (when (and angel from to)
    (list :|cemeteries| (hw:list-cemeteries angel :from from :to to)
          :|daily| (hw:list-summay-impure-cemeteries-by-date-damon angel :from from :to to))))


(defun pages-impure (angel impure)
  (when (and angel impure)
    (list :|impure|        (dao2impure impure :angel angel)
          :|deamon|        (or (dao2deamon (hw::impure-deamon impure)) :null)
          :|maledict|      (dao2maledict (hw::impure-maledict impure))
          :|angel|         (dao2angel (hw::impure-angel impure))
          :|purges|        (hw::impure-purge-list   impure)
          :|spells|        (hw::impure-spell-list   impure)
          :|requests|      (hw::impure-request-list impure)
          :|chains|        (hw::impure-chain-list   impure)
          :|relationships| (hw:list-relational-impures-by-impure impure))))


(defun pages-impures (angel maledict)
  (list :|impures| (hw:list-maledict-impures angel maledict)))


(defun pages-impure-waiting (angel impure)
  (when (and angel impure)
    (list :|impure|   (dao2impure   impure :angel angel)
          :|deamon|   (dao2deamon   (hw::impure-deamon   impure))
          :|maledict| (dao2maledict (hw::impure-maledict impure))
          :|angel|    (dao2angel    (hw::impure-angel impure))
          :|actions|  (hw:list-purge-by-impure impure)
          :|messages| (hw:list-request-messages-unred angel :impure impure))))


(defun pages-deamon (angel deamon)
  (when (and angel deamon)
    (let ((daily (hw:list-summary-purge-by-impure :deamon deamon)))
      (list :|deamon|  (dao2deamon deamon)
            :|impures| (hw:list-impures-by-deamon :deamon deamon)
            :|impure_purge_times| (hw:list-impures-purged-time-by-deamon :deamon deamon)
            :|purges|  (list :|summary| (list :|daily| daily)
                             :|total|   (list :|amount| (reduce #'(lambda (a b)
                                                                    (+ a (getf b :|elapsed_time|)))
                                                                daily :initial-value 0.0)
                                              :|unit| :second))))))


(defun pages-angel (angel from to)
  (list :|angel|   (dao2angel angel)
        :|purges|  (list :|deamons| (hw:list-summary-purge-by-angel-deamon-span angel :from from :to to)
                         :|impures| (hw:list-summary-purge-by-angel-impure-span angel :from from :to to)
                         :|days|    (list :|deamons| (hw:list-summary-purge-by-angel-span angel :from from :to to)))))

;;;;;
;;;;;
;;;;;
(defun pages-world (angel maledict-id orthodox-id)
  (let ((maledict (hw:get-maledict :angel angel :id maledict-id))
        (orthodox (hw:get-orthodox :id orthodox-id)))
    (when maledict-id (assert maledict))
    (when orthodox-id (assert orthodox))
    (list :|impures|  (and maledict (hw:list-maledict-impures angel maledict))
          :|orthodox| (dao2orthodox orthodox)
          :|orthodox_angels| (hw:list-orthodox-angels :orthodox orthodox))))
