<angel-page-card-result-deamon>

    <div class="controller">
        <p style="word-break: keep-all; margin-right:11px;">期間: </p>

        <input class="input is-small"
               type="date"
               placeholder="From"
               style="margin-right:11px;"
               value={opts.span.from.format('YYYY-MM-DD')}
               ref="from">

        <p style="margin-right:11px;">〜</p>

        <input class="input is-small"
               type="date"
               placeholder="To"
               style="margin-right:11px;"
               value={opts.span.to.format('YYYY-MM-DD')}
               ref="to">

        <button class="button is-small"
                onclick={clickRefresh}>Refresh</button>
    </div>

    <div class="summary" style="margin-top:11px;">
        <p style="margin-right:11px;">Total:</p>
        <p style="margin-right:11px;">{totalElapsedDay()}</p>
        <p style="margin-right:11px;">[人日]</p>
    </div>

    <div style="margin-top:11px;">
        <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;">
            <thead>
                <tr>
                    <th rowspan="2">ID</th>
                    <th rowspan="2">Name</th>
                    <th colspan="3">作業時間</th>
                </tr>
                <tr>
                    <th>人日</th>
                    <th>時間</th>
                    <th>分</th>
                </tr>
            </thead>
            <tbody>
                <tr each={obj in list()}>
                    <td>{obj.deamon_id}</td>
                    <td>{obj.deamon_name}</td>
                    <td class="num">{elapsedDay(obj.puge_elapsed_time)}</td>
                    <td class="num">{elapsedHour(obj.puge_elapsed_time)}</td>
                    <td class="num">{elapsedMinute(obj.puge_elapsed_time)}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
     this.clickRefresh = () => {
         this.opts.callback('click-refresh', {
             from: moment(this.refs.from.value),
             to:   moment(this.refs.to.value),
         })
     };
    </script>

    <script>
     let sum = this.totalElapsedDay = () => {
         let sum = opts.source.purges.deamons.reduce((a,b)=>{
             return a + b.puge_elapsed_time;
         }, 0);

         return this.elapsedDay(sum);
     };
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
     angel-page-card-result-deamon {
         display: flex;
         flex-direction: column;

         width: calc(11px * 8 * 6);

         padding: 22px;
         background: #fff;
         border-radius: 5px;
     }
     angel-page-card-result-deamon .controller {
         display: flex;
         align-items: center;
     }
     angel-page-card-result-deamon .summary {
         display: flex;
         align-items: center;
     }
    </style>

</angel-page-card-result-deamon>
