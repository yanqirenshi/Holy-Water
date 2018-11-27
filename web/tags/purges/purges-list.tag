<purges-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr>
                <th rowspan="2">Impure</th>
                <th colspan="4">Purge</th>
            </tr>
            <tr>
                <th>開始</th>
                <th>終了</th>
                <th>時間</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <tr each={opts.data}>
                <td>{impure_name}</td>
                <td>{fdt(start)}</td>
                <td>{fdt(end)}</td>
                <td style="text-align: right;">{elapsedTime(start, end)}</td>
                <td><button class="button"
                            data-id={id}
                            onclick={clickEditButton}>変更</button></td>
            </tr>
        </tbody>
    </table>

    <script>
     this.clickEditButton = (e) => {
         let target = e.target;

         this.opts.callback('open-purge-result-editor', {
             id: target.getAttribute('data-id')
         })
     };
    </script>

    <script>
     this.fdt = (dt) => {
         return dt ? moment(dt).format("YYYY-MM-DD HH:mm:ss") : '---';
     }
     this.elapsedTime = (start, end) => {
         if (!start || !end) return '';

         let int2dstr = (i) => {
             return (i<10) ? '0' + i : i + '';
         };

         let elapse = moment(end).diff(moment(start)) / 1000;

         let sec = elapse % 60;

         let elapse_min = (elapse - sec) / 60;

         let min = elapse_min % 60;

         let elapse_hour = (elapse_min - min) / 60;

         let hour = elapse_hour % 24;

         let day = (elapse_hour - hour) / 24;

         let time_str = int2dstr(hour) + ':' + int2dstr(min) + ':' + int2dstr(sec);
         let day_str = (day>0) ? day + ' 日 ' : '';

         return day_str + time_str;
     };
    </script>
</purges-list>
