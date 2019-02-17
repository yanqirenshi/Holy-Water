<cemetery-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr>
                <th colspan="3">Impure</th>
                <th colspan="2">Purge</th>
                <th rowspan="2">備考</th>
            </tr>
            <tr>
                <th>ID</th>
                <th>名称</th>
                <th>完了</th>
                <th>開始</th>
                <th>終了</th>
            </tr>
        </thead>
        <tbody>
            <tr each={impure in opts.data}>
                <td nowrap>{impure.id}</td>
                <td nowrap>{impure.name}</td>
                <td nowrap>{dt(impure.finished_at)}</td>
                <td nowrap>{dt(impure.start)}</td>
                <td nowrap>{dt(impure.end)}</td>
                <td style="word-break: break-word;">{description(impure.description)}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.dt = (v) => {
         if (!v) return '---'

         return moment(v).format('YYYY-MM-DD HH:mm:ss')
     };

     this.description = (str) => {
         if (str.length<=222)
             return str;

         return str.substring(0, 222) + '........';
     };
    </script>
</cemetery-list>
