(in-package :holy-water)


(defun %finish-impure (angel impure &key editor)
  (when (impure-purge-now-p angel impure)
    (error "この Impure は purge 中です。"))
  (let ((done-maledict (get-maledict-done :angel angel))
        (done-impure   (make-impure-finished impure :editor editor)))
    (move-impure angel impure done-maledict :editor editor)
    (delete-dao impure)
    (save-dao   done-impure)
    done-impure))

(defgeneric finish-impure (angel impure &key editor)
  (:method (angel (impure rs_impure-active) &key editor)
    (%finish-impure angel impure :editor editor))

  (:method (angel (impure rs_impure-finished) &key editor)
    (declare (ignore angel editor))
    (error "完了済みです。 impure=~S" impure))

  (:method (angel (impure rs_impure-discarded) &key editor)
    (declare (ignore angel editor))
    (error "削除済みです。 impure=~S" impure)))
