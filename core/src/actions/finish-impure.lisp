(in-package :holy-water)


(defun %finish-impure (angel impure &key editor with-stop)
  (when (impure-purge-now-p angel impure)
    (if with-stop
        (hw:stop-action-impure angel impure :editor angel)
        (error "この Impure は purge 中です。")))
  (let ((done-maledict (get-maledict-done :angel angel))
        (done-impure   (make-impure-finished impure :editor editor)))
    (move-impure angel impure done-maledict :editor editor)
    (delete-dao impure)
    (save-dao   done-impure)
    (find-dao 'rs_impure-finished :id (mito:object-id impure))))

(defgeneric finish-impure (angel impure &key editor with-stop)
  (:method (angel (impure rs_impure-active) &key editor with-stop)
    (%finish-impure angel impure :editor editor :with-stop with-stop))

  (:method (angel (impure rs_impure-finished) &key editor with-stop)
    (declare (ignore angel editor with-stop))
    (error "完了済みです。 impure=~S" impure))

  (:method (angel (impure rs_impure-discarded) &key editor with-stop)
    (declare (ignore angel editor with-stop))
    (error "削除済みです。 impure=~S" impure)))
