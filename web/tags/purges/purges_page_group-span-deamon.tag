<purges_page_group-span-deamon>
    <p>区分毎の作業時間</p>

    <table class="table is-bordered is-striped is-narrow is-hoverable"
           style="margin-top: 33px;">
        <thead>
            <tr>
                <th colspan="2">Deamon</th>
                <th colspan="2">Action Results</th>
            </tr>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Elapsed Time</th>
                <th>Count</th>
            </tr>
        </thead>

        <tbody>
            <tr each={rec in data()}>
                <td>{rec.deamon_name_short}</td>
                <td>{rec.deamon_name}</td>
                <td style="text-align:right;">{ts.format_sec(rec.elapsed_time)}</td>
                <td style="text-align:right;">{rec.purge_count}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.hw = new HolyWater();
     this.ts = new TimeStripper();

     this.data = () => {
         return this.opts.source
     };
    </script>

    <style>
     purges_page_group-span-deamon > p {
         width: 100%;
         color: #fff;
         font-weight: bold;
         text-shadow: 0px 0px 22px #333333;
         text-align: center;
         font-size: 22px;
     }
    </style>
</purges_page_group-span-deamon>
