<cemetery_page class="page-contents">

    <section class="section">
        <div class="container">
            <div>
                <cemetery_page_filter style="margin-bottom:22px;"
                                      from={from}
                                      to={to}
                                      callback={callback}></cemetery_page_filter>
            </div>

        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">日別推移</h1>

            <div style="padding-bottom:22px;">
                <cemetery-daily-list source={daily}></cemetery-daily-list>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">明細</h1>

            <div style="padding-bottom:22px;">
                <cemetery-list data={cemeteries}></cemetery-list>
            </div>
        </div>
    </section>

    <script>
     this.from = moment().add(-7, 'd').startOf('day');
     this.to   = moment().add(1,  'd').startOf('day');
     this.moveDate = (unit, amount) => {
         this.from = this.from.add(amount, unit);
         this.to   = this.to.add(amount, unit);

         this.tags['cemetery_page_filter'].update();
     };

     this.callback = (action, data) => {
         if ('move-date'==action) {
             this.moveDate(data.unit, data.amount);
             return;
         }
         if ('refresh'==action) {
             ACTIONS.fetchDoneImpures(this.from, this.to);
             return;
         }
     };
    </script>

    <script>
     this.impures = () => {
         return STORE.get('impures_done').list.sort((a, b) => {
             return a.id*1 < b.id*1 ? 1 : -1;
         });
     };
    </script>

    <script>
     this.cemeteries = [];
     this.daily      = [];
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DONE-IMPURES')
             this.update();

         if (action.type=='FETCHED-PAGES-CEMETERIES') {
             this.cemeteries = action.response.cemeteries;
             this.daily      = action.response.daily;

             this.update();
         }
     });

     this.on('mount', () => {
         ACTIONS.fetchDoneImpures(this.from, this.to);
         ACTIONS.fetchPagesCemeteries(this.from, this.to);
     });
    </script>

    <style>
     cemetery_page {
         height: 100%;
         display: block;
         overflow: scroll;
     }
    </style>
</cemetery_page>
