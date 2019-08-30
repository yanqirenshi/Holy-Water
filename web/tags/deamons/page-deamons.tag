<page-deamons class="page-contents">

    <section class="section" style="padding-top: 22px;">
        <div class="container">

            <div class="contents">
                <div>
                    <button class="button is-small" onclick={clickCreate}>Create Deamon</button>
                </div>

                <page-deamons_card-list></page-deamons_card-list>
            </div>
        </div>
    </section>

    <script>
     this.clickCreate = () => {
         ACTIONS.openModalCreateDeamon();
     };
     this.clickCreate = () => {
         ACTIONS.openModalCreateDeamon();
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DEAMONS')
             this.update();

         if (action.type=='CREATED-DEAMON')
             ACTIONS.fetchDeamons();
     });
    </script>

</page-deamons>
