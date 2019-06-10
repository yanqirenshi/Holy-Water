<home_maledicts-unread-message-counter>
    <p if={this.message_count>0}>(this.message_count)</p>

    <script>
     this.message_count = 0;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD') {
             this.message_count = STORE.get('requests.messages.unread.list').length;
             this.update();
         }
     })
    </script>

    <style>
     home_maledicts-unread-message-counter > p {
         font-size:12px;
         color:#a22041;
         padding-right:3px;
     }
    </style>
</home_maledicts-unread-message-counter>
