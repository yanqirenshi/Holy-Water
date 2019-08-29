<angel_page class="page-contents">

    <section class="section">
        <div class="container">

            <angel-page-card-result-deamon source={source}
                                           span={span}
                                           callback={callback}></angel-page-card-result-deamon>

            <!-- <angel-page-gitlab></angel-page-gitlab>

                 <angel-page-github></angel-page-github> -->

            <!-- <angel-page-change-password></angel-page-change-password>

                 <angel-page-sign-out></angel-page-sign-out>
            -->
        </div>
    </section>

    <script>
     this.callback = (action, data) => {
         if (action=='click-refresh') {
             this.span.from = data.from;
             this.span.to   = data.to;

             ACTIONS.fetchPagesSelf(this.span.from, this.span.to);
         }
     };
     this.span = {
         from: moment().startOf('month'),
         to:   moment().endOf('month'),
     };
     this.source = {
         angel: null,
         purges: {
             deamons: [],
             impures: [],
         }
     };
     this.on('mount', () => {
         ACTIONS.fetchPagesSelf(this.span.from, this.span.to);
     });
     STORE.subscribe((action)=>{
         if (action.type=='FETCHED-PAGES-SELF') {
             this.source = action.response;
             this.update();
             return;
         }
     });
    </script>

</angel_page>
