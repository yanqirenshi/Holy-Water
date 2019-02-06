<purges_page_group-span-deamon>
    <p>区分毎の作業時間</p>

    <table class="table" style="margin-top: 33px;">
        <thead>
            <tr>
                <th>Naem</th>
                <th>Time</th>
                <th>Count</th>
            </tr>
        </thead>

        <tbody>
            <tr each={deamon in data()}>
                <td>{deamon.name}</td>
                <td>{ts.format_sec(deamon.time)}</td>
                <td>{deamon.list.length}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.hw = new HolyWater();
     this.ts = new TimeStripper();

     this.data = () => {
         return this.hw.summaryPurgesAtDeamons(this.opts.data.list);
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
