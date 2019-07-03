<page-impure-incantation>

    <h1 class="title is-5" style="margin:0px;">呪文詠唱</h1>

    <div class="contents">

        <table class="table is-bordered is-striped is-narrow is-hoverable" style="font-size:14px;">
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
     page-impure-incantation {
         display: block;
         width:  calc(88px * 4 + 22px * 3);
         height: calc(88px * 3 + 22px * 2);
         padding: 22px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
         margin-bottom: 11px;
     }
     page-impure-incantation description-markdown pre {
         padding:0px;
     }
    </style>

</page-impure-incantation>
