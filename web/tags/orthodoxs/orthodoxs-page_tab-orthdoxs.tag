<orthodoxs-page_tab-orthdoxs>

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white"></h1>
            <div class="contents hw-text-white">
                <orthodox-list></orthodox-list>
            </div>
        </div>
    </section>

    <script>
     this.on('mount', () => {
         ACTIONS.fetchOrthodoxs();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOXS')
             this.tags['orthodox-list'].update();
     });
    </script>

</orthodoxs-page_tab-orthdoxs>
