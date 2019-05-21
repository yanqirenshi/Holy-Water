<purges-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth hw-box-shadow"
           style="font-size:12px;">
        <thead>
            <tr>
                <th colspan="2">Deamon</th>
                <th rowspan="2">Impure</th>
                <th colspan="4">Purge</th>
                <th colspan="3">作業間隔</th>
            </tr>
            <tr>
                <th>Name</th>
                <th>操作</th>
                <th>開始</th>
                <th>終了</th>
                <th>時間</th>
                <th>操作</th>
                <th>後作業</th>
                <th>前作業</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <tr each={rec in data()}
                purge_id={rec.purge_id}
                impure_id={rec.impure_id}
                deamon_id={rec.deamon_id}>
                <td>
                    <a href="#purges/deamons/{rec.deamon_id}">
                        {rec.deamon_name_short}
                    </a>
                </td>
                <td>
                    <button class="button is-small"
                            onclick={clickChangeDemon}>変</button>
                    <!-- <button class="button is-small" disabled>削</button> -->
                </td>
                <td>
                    <a href="#purges/impures/{rec.impure_id}">
                        {rec.impure_name}
                    </a>
                </td>
                <td>{fdt(rec.purge_start)}</td>
                <td>{fdt(rec.purge_end)}</td>
                <td style="text-align: right;">{elapsedTime(rec.purge_start, rec.purge_end)}</td>
                <td>
                    <button class="button is-small"
                            data-id={rec.purge_id}
                            before-end={beforEnd(rec)}
                            after-start={afterStart(rec)}
                            onclick={clickEditTermButton}>変</button>
                    <!-- <button class="button is-small" disabled>削</button> -->
                </td>
                <td style="text-align:right;">{fmtSpan(rec.distance.after)}</td>
                <td style="text-align:right;">{fmtSpan(rec.distance.befor)}</td>
                <td>
                    <button class="button is-small" disabled>変</button>
                </td>
            </tr>
        </tbody>
    </table>

    <script>
     this.ts = new TimeStripper();
     this.befor_data = null;
     this.fmtSpan = (v) => {
         if (!v && v!=0)
             return '';

         let ms = v % 1000;
         let sec = (v - ms) / 1000

         return this.ts.format_sec(Math.floor(sec));
     };
     this.data = () => {
         if (!this.opts.source)
             return [];

         let out = this.opts.source.sort((a, b) => {
             // 降順にソート
             return a.purge_start < b.purge_start ? 1 : -1;
         });

         let befor = null;
         let after = null;
         for (let rec of out) {
             rec.distance = { befor: null, after: null };

             if (after) {
                 let distance = after.purge_start.diff(rec.purge_end);
                 rec.after = after;
                 after.before = rec;

                 rec.distance.after = distance;
                 after.distance.befor = distance;
             }

             after = rec;
         }


         return out;
     };
    </script>

    <script>
     this.clickEditTermButton = (e) => {
         let target = e.target;

         this.opts.callback('open-purge-result-editor', {
             id: target.getAttribute('data-id'),
             before_end: target.getAttribute('before-end'),
             after_start: target.getAttribute('after-start'),
         })
     };
     this.clickChangeDemon = (e) => {
         let tr = e.target.parentNode.parentNode;

         this.opts.callback('open-modal-change-deamon', {
             purge_id: tr.getAttribute('purge_id'),
             impure_id: tr.getAttribute('impure_id'),
             deamon_id: tr.getAttribute('deamon_id'),
         })
     };
    </script>

    <script>
     this.beforEnd = (rec) => {
         if (!rec.before || !rec.before.purge_end)
             return null;

         return rec.before.purge_end.format('YYYY-MM-DD HH:mm:ss');
     };
     this.afterStart = (rec) => {
         if (!rec.after || !rec.after.purge_start)
             return null;

         return rec.after.purge_start.format('YYYY-MM-DD HH:mm:ss');
     };
     this.fdt = (dt) => {
         return dt.format('MM-DD HH:mm:ss')
     }
     this.elapsedTime = (start, end) => {
         return new TimeStripper().format_elapsedTime(start, end);
     };
    </script>

    <style>
     purges-list .table tbody td {
         vertical-align: middle;
     }
    </style>
</purges-list>
