<war-history-page_tab_days>

    <section class="section" style="padding-top:22px;">
        <div class="container">
            <hw-section-title title="日別/悪魔別" lev="4"></hw-section-title>
            <hw-section-subtitle contents="悪魔毎の棒グラフ"></hw-section-subtitle>
        </div>
    </section>

    <section class="section" style="padding-top:22px;">
        <div class="container">
            <hw-section-title title="悪魔別" lev="4"></hw-section-title>
            <hw-section-subtitle contents="悪魔別の円グラフ"></hw-section-subtitle>
        </div>
    </section>

    <section class="section" style="padding-top:22px;">
        <div class="container">
            <hw-section-title title="日別/悪魔別 明細" lev="4"></hw-section-title>

            <div class="contents" style="margin-top: 22px; padding-left: 22px;">
                <table class="table is-bordered is-striped is-narrow is-hoverable"
                       style="font-size: 12px;">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Elapsed Time [sec]</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={rec in opts.source.summary.deamons}>
                            <td>{dateVal(rec)}</td>
                            <td>{rec.deamon_id}</td>
                            <td>{rec.deamon_name}</td>
                            <td style="text-align: right;">{elapseTimeVal(rec)}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
     this.dateVal = (rec) => {
         return moment(rec.date).format('YYYY-MM-DD ddd');
     }
     this.elapseTimeVal = (rec) => {
         let t = rec.elapsed_time;

         let sec = t % 60;
         t = t - sec;

         let min = (t % (60 * 60)) / 60;
         t = t - min * 60;

         let hour = t / (60 * 60);

         let twoChar = (v) => {
             if (v<10)
                 return '0' + v;

             return '' + v;
         };

         return [hour, min, sec].map(twoChar).join(':');
     }
    </script>

</war-history-page_tab_days>
