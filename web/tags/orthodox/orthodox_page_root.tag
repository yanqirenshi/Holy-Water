<orthodox_page_root>
    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">正教会</h1>
            <h2 class="subtitle hw-text-white">正教会=チーム</h2>

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white">List</h1>
                    <div class="contents hw-text-white">
                        <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr each={orthodox in orthodoxs()}>
                                    <td>{orthodox.id}</td>
                                    <td>{orthodox.name}</td>
                                    <td>{orthodox.description}</td>
                                </tr>
                            </tbody>
                        </table>
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
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOXS')
             this.update();
     });
    </script>
</orthodox_page_root>
