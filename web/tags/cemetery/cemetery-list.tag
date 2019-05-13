<cemetery-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"
           style="font-size:12px;">
        <thead>
            <tr>
                <th colspan="1" rowspan="2">Deamon</th>
                <th colspan="5">Impure</th>
            </tr>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Finish Purge</th>
                <th>Action Count</th>
                <th>Total Time</th>
            </tr>
        </thead>
        <tbody>
            <tr each={cemetry in cemeteries()}>
                <td>
                    <a href="#cemeteries/deamons/{cemetry.deamon_id}">{cemetry.deamon_name_short}</a>
                </td>
                <td nowrap>
                    <a href="#cemeteries/impures/{cemetry.impure_id}">
                        {cemetry.impure_id}
                    </a>
                </td>
                <td>{cemetry.impure_name}</td>
                <td>{dt(cemetry.impure_finished_at)}</td>
                <td style="text-align: right;">{cemetry.purge_count}</td>
                <td style="text-align: right;">{cemetry.elapsed_time}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.cemeteries = () => {
         return opts.data.sort((a, b) => {
             return (a.impure_finished_at < b.impure_finished_at) ? 1 : -1;
         });
     };
     this.dt = (v) => {
         if (!v) return '---'

         return moment(v).format('MM-DD HH:mm:ss')
     };

     this.description = (str) => {
         if (str.length<=222)
             return str;

         return str.substring(0, 222) + '........';
     };
    </script>
</cemetery-list>
