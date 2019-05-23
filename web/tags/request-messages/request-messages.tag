<request-messages>

    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Request</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white">Messages</h1>

                    <div class="contents hw-text-white">
                        <request-messages-list source={source.unread}></request-messages-list>
                    </div>
                </div>
            </section>
        </div>
    </section>

    <script>
     this.source = { unread: [] };
    </script>

    <script>
     this.on('mount', () => {
         ACTIONS.fetchPagesHomeRequests();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-HOME-REQUESTS') {
             this.source.unread = action.response.unread;
             this.update();

             return;
         }

         if (action.type=='CHANGED-TO-READ-REQUEST-MESSAGE') {
             ACTIONS.fetchPagesHomeRequests();
             return;
         }
     });
    </script>

    <style>
     request-messages {
         width: 100%;
         height: 100%;
         display: block;
         overflow: auto;
     }
    </style>

</request-messages>
