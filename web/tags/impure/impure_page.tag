<impure_page>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">Impure</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <section class="section" style="padding-top:11px; padding-bottom:11px;">
        <div class="container">
            <impure_page-tabs></impure_page-tabs>
        </div>
    </section>

    <script>
     this.id = () => {
         return location.hash.split('/').reverse()[0];
     }
     this.name = () => {
         if (this.impure)
             return this.impure.name;

         return '';
     };
    </script>


    <script>
     this.impure = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-IMPURE') {
             this.impure = action.impure;
             this.update();
         }
     });
     this.on('mount', () => {
         ACTIONS.fetchImpure(this.id());
     });
    </script>
</impure_page>
