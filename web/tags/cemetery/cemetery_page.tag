<cemetery_page>
    <section class="section">
        <div class="container">
            <h2 class="subtitle" style="text-shadow: 0px 0px 11px #fff;"></h2>

            <div>
                <cemetery_page_filter style="margin-bottom:22px;"
                                      from={from}
                                      to={to}
                                      callback={callback}></cemetery_page_filter>
            </div>

            <div style="padding-bottom:22px;">
                <cemetery-list data={impures()}></cemetery-list>
            </div>
        </div>
    </section>

    <script>
     this.from = moment().add(-1, 'd').startOf('day');
     this.to   = moment().add(1, 'd').startOf('day');
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
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DONE-IMPURES')
             this.update();
     });

     this.on('mount', () => {
         ACTIONS.fetchDoneImpures(this.from, this.to);
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
