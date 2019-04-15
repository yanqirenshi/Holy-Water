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
                        <request-messages-list></request-messages-list>
                    </div>
                </div>
            </section>
        </div>
    </section>

    <script>
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD')
             this.update();
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
