<page-angel class="page-contents">

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">祓魔師</h1>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">パスワード変更</h1>
        </div>
    </section>


    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">Maledicts</h1>
            <page-angel-maledicts-card-pool></page-angel-maledicts-card-pool>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">外部システム連携</h1>
            <page-angel-external-service-card-pool></page-angel-external-service-card-pool>
        </div>
    </section>


    <section class="section">
        <div class="container">
            <h1 class="title is-4 hw-text-white">作業実績</h1>
            <page-angel-result-card-pool source={source}
                                         span={span}
                                         callback={callback}></page-angel-result-card-pool>
        </div>
    </section>

    <script>
     this.callback = (action, data) => {
         if (action=='click-refresh') {
             this.span.from = data.from;
             this.span.to   = data.to;

             ACTIONS.fetchPagesSelf(this.span.from, this.span.to);
         }
     };
     this.span = {
         from: moment().startOf('month'),
         to:   moment().endOf('month'),
     };
     this.source = {
         angel: null,
         purges: {
             deamons: [],
             impures: [],
         }
     };
     this.on('mount', () => {
         ACTIONS.fetchPagesSelf(this.span.from, this.span.to);
     });
     STORE.subscribe((action)=>{
         if (action.type=='FETCHED-PAGES-SELF') {
             this.source = action.response;
             this.update();
             return;
         }
     });
    </script>

</page-angel>
