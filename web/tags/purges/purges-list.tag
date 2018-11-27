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
         return new TimeStripper().format(dt);
     }
     this.elapsedTime = (start, end) => {
         return new TimeStripper().format_elapsedTime(start, end);
     };
    </script>
</purges-list>
