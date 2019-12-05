<page-angel-action-results_tab-total>

    <section class="section" style="padding-top:11px;">
        <div class="container">

            <div style="margin-top:11px;">
                <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;">
                    <thead>
                        <tr>
                            <th colspan="3">Deamon</th>
                            <th colspan="3">作業時間</th>
                        </tr>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Short Name</th>
                            <th>人日</th>
                            <th>時間</th>
                            <th>分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={obj in list()}>
                            <td>{obj.deamon_id}</td>
                            <td>{obj.deamon_name}</td>
                            <td>{obj.deamon_name_short}</td>
                            <td class="num">{elapsedDay(obj.puge_elapsed_time)}</td>
                            <td class="num">{elapsedHour(obj.puge_elapsed_time)}</td>
                            <td class="num">{elapsedMinute(obj.puge_elapsed_time)}</td>
                        </tr>
                    </tbody>
                </table>
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
         return opts.source.purges.deamons.sort((a,b)=>{
             return a.puge_elapsed_time < b.puge_elapsed_time ? 1 : -1;
         });
     };
    </script>

    <style>
     page-angel-action-results_tab-total {
         display: flex;
         flex-direction: column;
     }
     page-angel-action-results_tab-total .summary {
         display: flex;
         align-items: center;

         font-weight: bold;
     }
    </style>

</page-angel-action-results_tab-total>
