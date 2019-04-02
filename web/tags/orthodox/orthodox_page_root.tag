<orthodox_page_root>
    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">正教会</h1>
            <h2 class="subtitle hw-text-white">正教会=チーム</h2>

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white">Orthodoxs</h1>
                    <div class="contents hw-text-white">
                        <orthodox-list></orthodox-list>
                    </div>
                </div>
            </section>

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white">Exorcists</h1>
                    <div class="contents hw-text-white">
                        <exorcists-list></exorcists-list>
                    </div>
                </div>
            </section>
        </div>
    </section>


    <script>
     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };

     this.on('mount', () => {
         ACTIONS.fetchOrthodoxs();
         ACTIONS.fetchOrthodoxAllExorcists();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOXS')
             this.tags['orthodox-list'].update();

         if (action.type=='FETCHED-ORTHODOX-ALL-EXORCISTS')
             this.update();
     });
    </script>

    <style>
     orthodox_page_root {
         width: 100%;
         height: 100%;
         display: block;
         overflow: auto;
     }
    </style>

</orthodox_page_root>
