<cemetery_page_root>
    <section class="section">
        <div class="container">
            <h1 class="title" style="text-shadow: 0px 0px 11px #fff;">自身が Purge(完了) した Impure</h1>
            <h2 class="subtitle" style="text-shadow: 0px 0px 11px #fff;">準備中</h2>

            <div style="padding-bottom:22px;">
                <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>name</th>
                            <th>description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={impure in impures()}>
                            <td nowrap>{impure.id}</td>
                            <td nowrap>{impure.name}</td>
                            <td>{description(impure.description)}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
     this.description = (str) => {
         if (str.length<=222)
             return str;

         return str.substring(0, 222) + '........';
     };
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
         ACTIONS.fetchDoneImpures();
     });
    </script>

    <style>
     cemetery_page_root {
         height: 100%;
         display: block;
         overflow: scroll;
     }
    </style>
</cemetery_page_root>
