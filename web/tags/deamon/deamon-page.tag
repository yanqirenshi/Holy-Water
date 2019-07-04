<deamon-page>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">悪魔: {name()}</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <deamon-page-card-pool source={source}></deamon-page-card-pool>

    <script>
     this.name = () => {
         let deamon = this.source.deamon;
         if (!deamon)
             return '';

         return deamon.name;
     };
    </script>


    <script>
     this.source = {
         deamon: null,
         impures: [],
         purges: { summary: [] },
     };
     this.loadPageData = () => {
         let id = location.hash.split('/').reverse()[0];

         ACTIONS.fetchPagesDeamon({ id:id });
     }
     this.on('mount', () => {
         this.loadPageData();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-DEAMON') {
             this.source = action.response;

             this.update();
             return;
         }

         if (action.type=='UPDATED-DEAMON-DESCRIPTION') {
             this.loadPageData();

             return;
         }
     });
    </script>

    <style>
     deamon-page {
         overflow: auto;
         display: block;
         width: 100%;
         height: 100%;
     }
    </style>

</deamon-page>
