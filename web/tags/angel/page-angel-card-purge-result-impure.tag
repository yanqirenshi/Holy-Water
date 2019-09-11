<page-angel-card-purge-result-impure>

    <di>
        <div>
            <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Deamon</th>
                        <th>Impure</th>
                        <th>作業時間[h]</th>
                        <th>Purge Action数</th>
                    </tr>
                </thead>
                <tbody>
                    <tr each={obj in list()}>
                        <td nowrap>{obj.date}</td>
                        <td>{obj.deamon_name}</td>
                        <td>{obj.impure_name}</td>
                        <td style="text-align:right;">{elapsedHour(obj.elapsed_time)}</td>
                        <td>{obj.impure_count}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </di>

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
         dump(this.opts.source.purges.impures);

         if (!this.opts.source.purges ||
             !this.opts.source.purges.impures)
             return [];

         let list = this.opts.source.purges.impures;

         return list;
     };
    </script>


    <style>
     page-angel-card-purge-result-impure {
         display: flex;
         flex-direction: column;

         width: calc(11px * 8 * 12);

         padding: 22px;
         background: #fff;
         border-radius: 5px;
     }
    </style>

</page-angel-card-purge-result-impure>
