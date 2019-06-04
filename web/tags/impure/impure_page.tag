<impure_page>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">Impure</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <section class="section" style="padding-top:22px; padding-bottom:22px;">
        <div class="container">
            <div class="contents">
                <impure_page-controller source={term}
                                        impure={source.impure}
                                        callback={callback}></impure_page-controller>
            </div>
        </div>
    </section>


    <section class="section" style="padding-top:0px; padding-bottom:22px;">
        <div class="container">
            <page-tabs core={page_tabs}
                       callback={clickTab}></page-tabs>
        </div>
    </section>

    <div class="tab-contents-area">
        <impure_page_tab-basic       class="hide" source={source.impure}></impure_page_tab-basic>
        <impure_page_tab-purges      class="hide" source={source.purges}></impure_page_tab-purges>
        <impure_page_tab-incantation class="hide" source={source.spells}></impure_page_tab-incantation>
        <impure_page_tab-requests    class="hide" source={source.requests}></impure_page_tab-requests>
        <impure_page_tab-chains      class="hide" source={[]}></impure_page_tab-chains>
    </div>

    <script>
     this.callback = (action, data) => {
         if (action=='refresh') {
             let id = this.id();
             ACTIONS.fetchPagesImpure({ id: id });

             return ;
         }
     };
    </script>

    <script>
     this.term = {
         from: moment().add('month', -1),
         to:   moment(),
     }
     this.page_tabs = new PageTabs([
         {code: 'basic',       label: '基本情報', tag: 'impure_page_tab-basic' },
         {code: 'purges',      label: '浄化履歴', tag: 'impure_page_tab-purges' },
         {code: 'incantation', label: '詠唱履歴', tag: 'impure_page_tab-incantation' },
         {code: 'requests',    label: '依頼履歴', tag: 'impure_page_tab-requests' },
         {code: 'chains',      label: '連鎖',     tag: 'impure_page_tab-chains' },
     ]);

     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
    </script>

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
     this.source = {
         impure: null,
         purges: [],
         spells: [],
         requests: [],
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-IMPURE') {
             this.source = action.response;

             this.update();
         }
     });
     this.on('mount', () => {
         let id = this.id();

         ACTIONS.fetchPagesImpure({ id: id });
         ACTIONS.fetchImpure(id);
     });
    </script>

    <style>
     impure_page page-tabs li a{
         background: #fff;
     }
    </style>

    <style>
     impure_page {
         width: 100%;
         height: 100%;
         display: block;
         overflow: auto;
     }
    </style>

    <style>
     impure_page .tabs ul {
         border-bottom-color: rgb(254, 242, 99);
         border-bottom-width: 2px;
     }
     impure_page .tabs.is-boxed li.is-active a {
         background-color: rgba(254, 242, 99, 1);
         border-color: rgb(254, 242, 99);

         text-shadow: 0px 0px 11px #fff;
         color: #333;
         font-weight: bold;
     }
     impure_page .tabs.is-boxed  li {
         margin-left: 8px;
     }
     impure_page .tabs.is-boxed a {
         text-shadow: 0px 0px 8px #fff;
         font-weight: bold;
     }
     impure_page .table th, impure_page .table td {
         font-size: 14px;
     }
    </style>
</impure_page>
