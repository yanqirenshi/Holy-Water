<impure_page_tab-purges>

    <section class="section" style="padding:0px;">
        <div class="container">
            <h1 class="title hw-text-white"></h1>

            <div class="contents">
                <table class="table is-bordered is-striped is-narrow is-hoverable">
                    <thead>
                        <tr>
                            <th colspan="6">Purge</th>
                            <th colspan="2">祓魔師</th>
                        </tr>
                        <tr>
                            <th>ID</th>
                            <th colspan="2">Start</th>
                            <th colspan="2">End</th>
                            <th>Elapsed Time [s]</th>
                            <th>ID</th>
                            <th>Name</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr each={rec in opts.source}>
                            <td>{rec.id}</td>
                            <td>{dt(rec.start)}</td>
                            <td>{week(rec.start)}</td>
                            <td>{dt(rec.end)}</td>
                            <td>{week(rec.end)}</td>
                            <td style="text-align:right;">{time(rec.elapsed_time)}</td>
                            <td>{rec.angel_id}</td>
                            <td>{rec.angel_name}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </section>

    <script>
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.time = (v) => { return hw.int2hhmmss(v); };
    </script>

</impure_page_tab-purges>
