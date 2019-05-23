<impure_page_tab-incantation>

    <section class="section" style="padding:0px;">
        <div class="container">
            <h1 class="title hw-text-white"></h1>

            <div class="contents">

                <table class="table is-bordered is-striped is-narrow is-hoverable">
                    <thead>
                        <tr>
                            <th rowspan="2">ID</th>
                            <th rowspan="2" colspan="2">Date</th>
                            <th colspan="2">祓魔師</th>
                            <th rowspan="2">Spell</th>
                        </tr>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr each={rec in opts.source}>
                            <td>{rec.id}</td>
                            <td>{dt(rec.incantation_at)}</td>
                            <td>{week(rec.incantation_at)}</td>
                            <td>{rec.angel_id}</td>
                            <td>{rec.angel_name}</td>
                            <td>
                                <description-markdown source={contents(rec.spell)}></description-markdown>
                            </td>
                    </tbody>
                </table>

            </div>

        </div>
    </section>

    <script>
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.contents = (v) => {
         /* return hw.descriptionViewShort(v); */
         return v;
     };
    </script>

    <style>
     impure_page_tab-incantation description-markdown pre { padding:0px; }
     impure_page_tab-incantation > .section { margin-bottom: 222px;}
    </style>
</impure_page_tab-incantation>
