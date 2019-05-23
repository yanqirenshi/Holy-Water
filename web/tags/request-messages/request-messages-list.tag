<request-messages-list>

    <table class="table is-bordered is-striped is-narrow is-hoverable">

        <thead>
            <tr>
                <th rowspan="2"></th>
                <th colspan="4">Request</th>
                <th colspan="2">Impure</th>
            </tr>
            <tr>
                <th>発生日時</th>
                <th colspan="2">From</th>
                <th class="message">Contents</th>
                <th>ID</th>
                <th>Name</th>
            </tr>
        </thead>

        <tbody>
            <tr each={message in source()}>
                <td>
                    <button class="button is-small"
                            message-id="{message.message_id}"
                            onclick={clickToReaded}>既読にする</button>
                </td>

                <td nowrap>{dt(message.requested_at)}</td>

                <td nowrap>{message.angel_from_id}</td>
                <td nowrap>{message.angel_from_name}</td>

                <td class="message">
                    <pre>{message.message_contents}</pre>
                </td>

                <td>
                    <a href="#home/requests/impures/{message.impure_id}">
                        {message.impure_id}
                    </a>
                </td>

                <td style="width:333px;">{message.impure_name}</td>
            </tr>
        </tbody>

    </table>

    <script>
     this.source = () => {
         if (!this.opts.source)
             return [];

         return this.opts.source.sort((a, b) => {
             if (new Date(a.requested_at) > new Date(b.requested_at))
                 return -1;
             else
                 return 1;
         });
     };
     this.dt = (v) => {
         if (!v)
             return '---';

         return moment(v).format('YYYY-MM-DD HH:mm')
     };
     let hw = new HolyWater();
     this.contents = (v) => {
         return hw.descriptionViewShort(v);
     };
     this.clickToReaded = (e) => {
         let button = e.target;
         button.setAttribute('disabled', true)

         let id = button.getAttribute('message-id');

         ACTIONS.changeToReadRequestMessage(id);
     };
    </script>

    <style>
     request-messages-list .table td {
         font-size:14px;
         vertical-align: middle;
     }
     request-messages-list .message > pre {
         padding: 8px;
     }
    </style>

</request-messages-list>
