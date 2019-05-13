<deamons-page class="page-contents">

    <section class="section" style="padding-top: 22px;">
        <div class="container">

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white"></h1>

                    <div class="contents">
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
            </section>

        </div>
    </section>

    <script>
     this.idLink = (deamon) => {
         return '#deamons/' + deamon.id;
     };
     this.deamons = () => {
         return STORE.get('deamons.list');
     };
     this.on('mount', () => {
         ACTIONS.fetchDeamons();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DEAMONS')
             this.update();
     });
    </script>

</deamons-page>
