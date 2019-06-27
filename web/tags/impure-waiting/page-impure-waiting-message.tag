<page-impure-waiting-message>

    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Messages</h1>

            <div class="contents">
                <table class="table is-bordered is-striped is-narrow is-hoverable"
                       style="font-size:12px;">
                    <thead>
                        <tr>
                            <th colspan="6">Request</th>
                            <th colspan="2">Message</th>
                        </tr>
                        <tr>
                            <th>id</th>
                            <th>time</th>
                            <th colspan="2">from</th>
                            <th colspan="2">to</th>
                            <th>id</th>
                            <th>contents</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={msg in opts.source.messages}>
                            <td>{msg.ev_request.id}</td>
                            <td>{hw.str2yyyymmddhhmmss(msg.ev_request.requested_at)}</td>
                            <td>{msg.angel_from_id}</td>
                            <td>{msg.angel_from_name}</td>
                            <td>{msg.angel_to_id}</td>
                            <td>{msg.angel_to_name}</td>
                            <td>{msg.message_id}</td>
                            <td>{msg.message_contents}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
     this.hw = new HolyWater();
    </script>

</page-impure-waiting-message>
