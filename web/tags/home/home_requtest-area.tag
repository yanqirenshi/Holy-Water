<home_request-area>
    <p class={isHide()}>
        依頼メッセージ未読: <a href="#home/requests"><span class="count">{count()}</span></a> 件
    </p>

    <script>
     this.isHide = () => {
         return this.count()==0 ? 'hide' : '';
     };
     this.count = () => {
         let list = STORE.get('requests.messages.unread.list');

         if (!list)
             return 0;

         return list.length;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD') {
             this.update();
             ACTIONS.notifyNewMessages();
         }
     });
    </script>

    <style>
     home_request-area > p {
         color: #fff;
         font-weight: bold;
         font-size: 14px;
         line-height: 38px;
     }

     home_request-area .count {
         color: #f00;
         font-size: 21px;
     }
    </style>
</home_request-area>
