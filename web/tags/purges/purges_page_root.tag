<purges_page_root>
    <div style="padding:22px;">
        <div class="card">
            <header class="card-header">
                <p class="card-header-title">Purge hisotry</p>
                <button class="button refresh" onclick={clickRefresh}>Refresh</button>
            </header>

            <div class="card-content">
                <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
                    <thead>
                        <tr>
                            <th rowspan="2">Impure</th>
                            <th colspan="3">Purge</th>
                        </tr>
                        <tr>
                            <th>開始</th>
                            <th>終了</th>
                            <th>時間</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={data()}>
                            <td>{impure_name}</td>
                            <td>{fdt(start)}</td>
                            <td>{fdt(end)}</td>
                            <td style="text-align: right;">{elapsedTime(start, end)}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
     this.clickRefresh = () => {
         ACTIONS.fetchPurgeHistory();
     };
    </script>

    <script>
     this.data = () => {
         let list = STORE.get('purges').list.sort((a, b) => {
             return a.start < b.start ? 1 : -1;
         });

         return list;
     };
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
     this.on('mount', () => {
         ACTIONS.fetchPurgeHistory();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PURGE-HISTORY')
             this.update();
     });
    </script>

    <style>
     purges_page_root {
         height: 100%;
         width: 100%;
         display: block;
         overflow: auto;
     }

     purges_page_root .card {
         border-radius: 8px;
     }

     purges_page_root button.refresh{
         margin-top:6px;
         margin-right:8px;
     }
    </style>
</purges_page_root>
