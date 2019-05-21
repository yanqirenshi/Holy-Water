<impure_page_tab-requests>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white"></h1>

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
                            <td>{contents(rec.contents)}</td>
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
     this.contents = (v) => { return hw.descriptionViewShort(v); };
    </script>

</impure_page_tab-requests>
