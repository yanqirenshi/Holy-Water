<deamons-page class="page-contents">

    <section class="section" style="padding-top: 22px;">
        <div class="container">

            <div class="contents">
                <div>
                    <div>
                        <button class="button is-small" onclick={clickCreate}>Create Deamon</button>
                    </div>

                    <div style="margin-top:22px;">
                        <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Name(Short)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr each={deamon in deamons()}>
                                    <td><a href={idLink(deamon)}>{deamon.id}</a></td>
                                    <td>{deamon.name}</td>
                                    <td>{deamon.name_short}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <script>
     this.idLink = (deamon) => {
         return '#deamons/' + deamon.id;
     };
     this.deamons = () => {
         return STORE.get('deamons.list');
     };
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

</deamons-page>
