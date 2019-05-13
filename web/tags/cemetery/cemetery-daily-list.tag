<cemetery-daily-list>

    <table class="table is-bordered is-striped is-narrow is-hoverable"
           style="font-size:12px;">
        <thead>
            <tr>
                <th>Date</th>
                <th>Deamon</th>
                <th>Action Count</th>
            </tr>
        </thead>
        <tbody>
            <tr each={cemetry in daily()}>
                <td>{cemetry.finished_at}</td>
                <td>{cemetry.deamon_name_short}</td>
                <td>{cemetry.purge_count}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.daily = () => {
         return this.opts.source.sort((a, b) => {
             return (a.finished_at < b.finished_at) ? 1 : -1;
         });
     };
     /* deamon_id: null
      * deamon_name: null
      * deamon_name_short: null
      * finished_at: "2019-05-07"
      * purge_count: 3 */
    </script>

</cemetery-daily-list>
