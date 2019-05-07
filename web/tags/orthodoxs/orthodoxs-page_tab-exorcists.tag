<orthodoxs-page_tab-exorcists>

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white"></h1>
            <div class="contents hw-text-white">
                <exorcists-list></exorcists-list>
            </div>
        </div>
    </section>

    <script>
     this.on('mount', () => {
         ACTIONS.fetchOrthodoxAllExorcists();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOX-ALL-EXORCISTS')
             this.update();
     });
    </script>

</orthodoxs-page_tab-exorcists>
