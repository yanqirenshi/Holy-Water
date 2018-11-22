
# Drop Table

```
drop table rs_angel;
drop table rs_maledict;
drop table th_angel_maledict;
drop table rs_impure;
drop table rs_impure_active;
drop table rs_impure_finished;
drop table rs_impure_discarded;
drop table ev_collect_impure;
drop table ev_collect_impure_history;
drop table ev_purge_start;
drop table ev_purge_end;
```

# Create Table

```
(in-package :holy-water)

(mapc #'mito:execute-sql (mito:table-definition 'rs_angel))
(mapc #'mito:execute-sql (mito:table-definition 'rs_maledict))
(mapc #'mito:execute-sql (mito:table-definition 'th_angel-maledict))
(mapc #'mito:execute-sql (mito:table-definition 'rs_impure-active))
(mapc #'mito:execute-sql (mito:table-definition 'rs_impure-finished))
(mapc #'mito:execute-sql (mito:table-definition 'rs_impure-discarded))
(mapc #'mito:execute-sql (mito:table-definition 'ev_collect-impure))
(mapc #'mito:execute-sql (mito:table-definition 'ev_collect-impure-history))
(mapc #'mito:execute-sql (mito:table-definition 'ev_purge-start))
(mapc #'mito:execute-sql (mito:table-definition 'ev_purge-end))
```
