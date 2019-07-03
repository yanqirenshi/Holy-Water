<page-impure-requests>

    <h1 class="title is-5">依頼履歴</h1>

    <div class="contents">
        <table class="table is-bordered is-striped is-narrow is-hoverable">
            <thead>
                <tr>
                    <th rowspan="2" colspan="2">Date</th>
                    <th colspan="2">From</th>
                    <th colspan="2">To</th>
                    <th rowspan="2">Message</th>
                </tr>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>ID</th>
                    <th>Name</th>
                </tr>
            </thead>
            <tbody>
                <tr each={rec in opts.source}
                    request-message-id={rec.id}
                    angel-from-id={rec.angel_from_id}
                    angel-to-id={rec.angel_to_id}
                    impure-id={rec.impure_id}>
                    <td>
                        {dt(rec.messaged_at)}
                    </td>
                    <td>
                        {week(rec.messaged_at)}
                    </td>
                    <td>
                        {rec.angel_from_id}
                    </td>
                    <td>{rec.angel_from_name}</td>
                    <td>
                        {rec.angel_to_id}
                    </td>
                    <td>{rec.angel_to_name}</td>
                    <td>
                        <description-markdown source={contents(rec.contents)}></description-markdown>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.contents = (v) => { return hw.descriptionViewShort(v); };
    </script>

    <style>
     page-impure-requests {
         display: block;
         width:  calc(88px * 4 + 22px * 3);
         height: calc(88px * 3 + 22px * 2);
         padding: 22px;
         background: rgba(255,255,255,0.88);
         border-radius: 8px;
         margin-bottom: 11px;
     }
    </style>

</page-impure-requests>
