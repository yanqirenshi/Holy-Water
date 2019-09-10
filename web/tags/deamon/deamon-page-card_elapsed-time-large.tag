<deamon-page-card_elapsed-time-large>
    <div class="hw-card-header">
        <p>Elapsed Time</p>
        <button class="button is-small">Close</button>
    </div>


    <div class="time">
        {amount()}
        <div style="text-align: right;width: 100%;padding-right: 33px;font-size: 12px;color: #888;">
            <p>[hour]</p>
        </div>
    </div>

    <div style="padding:22px; flex-grow:1; overflow:auto;">
        <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;">
            <tehad>
                <tr>
                    <th rowspan="2">Date</th>
                    <th colspan="2">Impure</th>
                    <th colspan="2">Elapsed Time</th>
                    <th rowspan="2">Action Count</th>
                </tr>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Days</th>
                    <th>Hours</th>
                </tr>
            </tehad>
            <tbody>
                <tr each={obj in list()}>
                    <td nowrap>{obj.date}</td>
                    <td nowrap>{obj.impure_id}</td>
                    <td>{obj.impure_name}</td>
                    <td nowrap>{days(obj.elapsed_time)}</td>
                    <td nowrap>{hours(obj.elapsed_time)}</td>
                    <td nowrap>{obj.impure_count}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
     this.amount = () => {
         let total = this.opts.source.purges.total;
         if (!total)
             return '';

         return (total.amount / 60 / 60).toFixed(2);
     };
     this.days = (v) => {
         return (v / 60 / 60 / 6).toFixed(2);
     };
     this.hours = (v) => {
         return (v / 60 / 60).toFixed(2);
     };
     this.list = () => {
         let summary = this.opts.source.purges.summary;
         if (!summary)
             return [];

         return summary.daily;
     };
    </script>

    <style>
     deamon-page-card_elapsed-time-large {
         display: flex;
         flex-direction: column;

         width: calc(11px * 32 + 11px * 31);
         height: calc(11px * 24 + 11px *  23);

         margin-bottom: 11px;

         background: rgba(255, 255, 255, 0.88);
         border-radius: 8px;
     }
     deamon-page-card_elapsed-time-large .hw-card-header {
         width: 100%;
         eight: 44px;

         padding: 8px 11px;
         border-radius: 8px 8px 0px 0px;

         font-size: 12px;
         font-weight: bold;

         background: #e7e7eb;
         color: #333333;

         display: flex;
         justify-content: space-between;
     }
     deamon-page-card_elapsed-time-large > .time {
         display: flex;
         flex-direction: column;

         justify-content: center;
         align-items: center;
         font-size: 66px;
     }
    </style>

</deamon-page-card_elapsed-time-large>
