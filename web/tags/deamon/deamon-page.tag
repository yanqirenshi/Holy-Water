<deamon-page>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h2 class="subtitle hw-text-white" style="margin-bottom: 6px;">
                <section-breadcrumb></section-breadcrumb>
            </h2>

            <deamon-page-name source={source}></deamon-page-name>
        </div>
    </section>

    <div style="display: flex; padding: 0px 88px;margin-top:22px;">
        <deamon-page-card-pool  source={source}></deamon-page-card-pool>
        <deamon-page-controller source={source}></deamon-page-controller>
    </div>

    <script>
     this.source = {
         deamon: null,
         impures: [],
         purges: { summary: [] },
     };
     this.getID = () => {
         let id = location.hash.split('/').reverse()[0] * 1;

         return id;
     }
     this.loadPageData = () => {
         let id = this.getID();

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

         if (action.type=='CREATED-IMPURE-DEAMON-IMPURE') {
             let id = this.getID();
             if (action.deamon.id==id)
                 ACTIONS.fetchPagesDeamon({ id:id });

             return;
         }
         if (action.type=='UPDATED-DEAMON-NAME') {
             let id = this.getID();

             if (action.deamon.id==id)
                 ACTIONS.fetchPagesDeamon({ id:id });

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
     deamon-page page-card_description-small {
         margin-bottom: 11px;
     }
     deamon-page deamon-page-card-pool {
         flex-grow: 1;
     }
    </style>

</deamon-page>
