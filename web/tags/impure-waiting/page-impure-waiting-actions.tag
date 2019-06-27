<page-impure-waiting-actions>

    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Actions</h1>

            <div class="contents">
                <table class="table is-bordered is-striped is-narrow is-hoverable"
                       style="font-size:12px;">
                    <thead>
                        <tr>
                            <th colspan="2">Angel</th>
                            <th colspan="5">Purge</th>
                        </tr>

                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>ID</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Elapsed</th>
                            <th>Description</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr each={action in opts.source.actions}>
                            <td>{action.angel_id}</td>
                            <td>{action.angel_name}</td>
                            <td>{action.purge_id}</td>
                            <td>{hw.str2yyyymmddhhmmss(action.purge_start)}</td>
                            <td>{hw.str2yyyymmddhhmmss(action.purge_end)}</td>
                            <td>{hw.int2hhmmss(action.elapsed_time)}</td>
                            <td>{action.purge_description}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </section>

    <script>
     this.hw = new HolyWater();
    </script>

</page-impure-waiting-actions>
