<page-impure-waiting>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">{xxx}</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Impure</h1>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Actions</h1>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title hw-text-white">Messages</h1>
        </div>
    </section>

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
             dump(action.response);
         }
     });
    </script>

</page-impure-waiting>
