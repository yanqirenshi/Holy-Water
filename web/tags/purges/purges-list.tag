<purges-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth hw-box-shadow"
           style="font-size:12px;">
        <thead>
            <tr>
                <th rowspan="2">Impure</th>
                <th colspan="5">Purge</th>
            </tr>
            <tr>
                <th>開始</th>
                <th>終了</th>
                <th>時間</th>
                <th>間隔</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <tr each={data()}>
                <td>{impure_name}</td>
                <td>{fdt(start)}</td>
                <td>{fdt(end)}</td>
                <td style="text-align: right;">{elapsedTime(start, end)}</td>
                <td>{span(this)}</td>
                <td><button class="button is-small"
                            data-id={id}
                            onclick={clickEditButton}>変更</button></td>
            </tr>
        </tbody>
    </table>

    <script>
     this.befor_data = null;
     this.span = (d) => {
         if (!this.befor_data) {
             this.befor_data = d;
             return '---';
         }

         let x = new TimeStripper().format_elapsedTime (d.end, this.befor_data.start);

         this.befor_data = d;

         return x;
     };
     this.data = () => {
         this.befor_data = null;

         return opts.data.list.sort((a, b) => {
             return a.start < b.start ? 1 : -1;
         });
     };
    </script>

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
         return new TimeStripper().format(dt);
     }
     this.elapsedTime = (start, end) => {
         return new TimeStripper().format_elapsedTime(start, end);
     };
    </script>
</purges-list>
