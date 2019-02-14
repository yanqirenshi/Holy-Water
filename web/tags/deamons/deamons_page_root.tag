<deamons_page_root>
    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Deamons</h1>
            <h2 class="subtitle"></h2>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-3 hw-text-white">List</h1>

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
                            <td>{deamon.id}</td>
                            <td>{deamon.name}</td>
                            <td>{deamon.name_short}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
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

</deamons_page_root>