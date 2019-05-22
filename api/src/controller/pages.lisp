(in-package :holy-water.api.controller)

(defun pages-orthodox (orthodox &key angel)
  (declare (ignore angel))
  (list :|orthodox| (dao2orthodox orthodox)
        :|primate|  :null ;; 首座主教。 オーナー
        :|paladin|  nil   ;; かんりしゃけんげんをもつ。
        :|angels|   nil))

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
    (list :|impure|   (dao2impure   impure)
          :|deamon|   (dao2deamon   (hw::impure-deamon   impure))
          :|maledict| (dao2maledict (hw::impure-maledict impure))
          :|purges|   (hw::impure-purge-list   impure)
          :|spells|   (hw::impure-spell-list   impure)
          :|requests| (hw::impure-request-list impure)
          :|chains|   (hw::impure-chain-list   impure))))