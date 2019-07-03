<page-impure-purges>

    <h1 class="title is-5" style="margin:0px;">浄化履歴</h1>

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

    <script>
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.time = (v) => { return hw.int2hhmmss(v); };
    </script>

    <style>
     page-impure-purges {
         display: block;
         width:  calc(88px * 4 + 22px * 3);
         height: calc(88px * 3 + 22px * 2);
         padding: 22px;
         background: rgba(255,255,255,0.88);
         border-radius: 8px;
         margin-bottom: 11px;
     }
    </style>

</page-impure-purges>
