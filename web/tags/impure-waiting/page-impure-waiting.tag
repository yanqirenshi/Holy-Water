<page-impure-waiting>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">{xxx}</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <page-impure-waiting-basic   source={source}></page-impure-waiting-basic>
    <page-impure-waiting-actions source={source}></page-impure-waiting-actions>
    <page-impure-waiting-message source={source}></page-impure-waiting-message>

    <script>
     this.source = {
         impure: null,
         maledict: null,
         angel: null,
         actions: [],
         messages: [],
     }
     this.on('mount', () => {
         let impure_id = location.hash.split('/').reverse()[0] * 1;

         ACTIONS.fetchPagesImpureWaiting({id: impure_id});
     })
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-IMPURE-WAITING') {
             this.source = action.response;
             this.update();
         }
     });
    </script>

</page-impure-waiting>
