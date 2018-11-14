```
drop table rs_angel;
drop table rs_maledict;
drop table th_angel_maledict;
drop table rs_impure;
drop table ev_collect_impure;
drop table ev_collect_impure_history;
drop table ev_purge_start;
drop table ev_purge_end;
```

```

(mapc #'mito:execute-sql (mito:table-definition 'rs_angel))
(mapc #'mito:execute-sql (mito:table-definition 'rs_maledict))
(mapc #'mito:execute-sql (mito:table-definition 'th_angel-maledict))
(mapc #'mito:execute-sql (mito:table-definition 'rs_impure))
(mapc #'mito:execute-sql (mito:table-definition 'ev_collect-impure))
```
