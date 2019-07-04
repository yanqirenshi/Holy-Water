<deamon-page>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">悪魔</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <deamon-page-card-pool></deamon-page-card-pool>

    <script>
     this.on('mount', () => {
         let id = location.hash.split('/').reverse()[0];

         ACTIONS.fetchPagesDeamon({ id:id });
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-DEAMON') {
             dump(action);
             return;
         }
     });
    </script>

</deamon-page>
