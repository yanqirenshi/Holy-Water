<message-area>
    <message-item each={msg in messages()}
                  data={msg}
                  callback={callback}></message-item>

    <script>
     this.callback = (action, data) => {
         if ('close-message'==action)
             ACTIONS.closeMessage(data);
     };
     STORE.subscribe((action) => {
         if ('CLOSED-MESSAGE'==action.type)
             this.update();
     });
    </script>

    <script>
     this.messages = () => {
         return STORE.get('messages');
     };
    </script>

    <style>
     message-area {
         position: fixed;
         right: 22px;
         top: 22px;
         z-index: 666666;
     }
     message-area > message-item {
         margin-bottom: 11px;
     }
     message-area > message-item:last-child {
         margin-bottom: 0px;
     }
    </style>
</message-area>
