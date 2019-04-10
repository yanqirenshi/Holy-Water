<request-messages-list>

    <table class="table is-bordered is-striped is-narrow is-hoverable">

        <thead>
            <tr>
                <th></th>
                <th>ID</th>
                <th>発生日時</th>
                <th>Impure</th>
                <th>From</th>
                <th class="message">Contents</th>
            </tr>
        </thead>

        <tbody>
            <tr each={message in sources()}>
                <td>
                    <button class="button"
                            message-id="{message.id}"
                            onclick={clickToReaded}>既読にする</button>
                </td>
                <td>
                    <a href="#home/requests/impures/{message.id}">{message.id}</a>
                </td>
                <td>{dt(message.messaged_at)}</td>
                <td>{message.impure_id}</td>
                <td>{message.angel_id_from}</td>
                <td class="message">
                    <pre>{message.contents}</pre>
                </td>
            </tr>
        </tbody>

    </table>

    <script>
     this.sources = () => {
         return STORE.get('requests.messages.unread.list').sort((a, b) => {
             if (new Date(a.messaged_at) > new Date(b.messaged_at))
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
     this.contents = (v) => {
         let lines = v.split('\n').filter((d) => {
             return d.trim().length > 0;
         });

         let suffix = '';
         if (lines.length>1 || lines[0].length>33)
             suffix = '...';

         let val = lines[0];
         if (val.length>33)
             val = val.substring(0,33);

         return val + suffix;
     };
     this.clickToReaded = (e) => {
         let button = e.target;
         button.setAttribute('disabled', true)

         let id = button.getAttribute('message-id');

         ACTIONS.changeToReadRequestMessage(id);
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD')
             this.update();
     });
    </script>

</request-messages-list>
