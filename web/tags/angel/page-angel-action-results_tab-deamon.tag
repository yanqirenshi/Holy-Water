<page-angel-action-results_tab-deamon>

    <section class="section" style="padding-top:11px;">
        <div class="container">
            <div class="controller">

                <di>
                    <div>
                        <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;">
                            <thead>
                                <tr>
                                    <th rowspan="2">Date</th>
                                    <th colspan="2">Deamon</th>
                                    <th colspan="2">作業結果</th>
                                </tr>

                                <tr>
                                    <th>Name</th>
                                    <th>Short Name</th>
                                    <th>作業時間[人日]</th>
                                    <th>Purge Action数</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr each={obj in list()}>
                                    <td nowrap>{obj.date}</td>
                                    <td>{obj.deamon_name}</td>
                                    <td>{obj.deamon_name_short}</td>
                                    <td style="text-align:right;">{elapsedDay(obj.elapsed_time)}</td>
                                    <td>{obj.impure_count}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </di>
            </div>
        </div>
    </section>

    <script>
     this.elapsedDay = (val) => {
         return (Math.ceil(this.elapsedHour(val) / 6 * 100) /100).toFixed(2);
     };
     this.elapsedHour = (val) => {
         return (Math.ceil(this.elapsedMinute(val) / 60 * 100) /100).toFixed(2);
     };
     this.elapsedMinute = (val) => {
         return (Math.ceil(val / 60 * 100) / 100).toFixed(2);
     };
     this.list = () => {
         if (!this.opts.source.purges ||
             !this.opts.source.purges.days ||
             !this.opts.source.purges.days.deamons)
             return [];

         let list = this.opts.source.purges.days.deamons.sort((a, b) => {
             return a.date < b.date ? 1 : -1;
         });

         return list;
     };
    </script>


    <style>
     page-angel-action-results_tab-deamon {
         display: flex;
         flex-direction: column;
     }
    </style>

</page-angel-action-results_tab-deamon>
