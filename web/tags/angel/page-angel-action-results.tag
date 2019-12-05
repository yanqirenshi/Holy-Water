<page-angel-action-results>

    <section class="section" style="padding-top: 55px; padding-bottom: 11px;">
        <div class="container">
            <h1 class="title is-4 hw-text-white">作業実績</h1>

            <page-angel-action-results-controller source={opts.source}
                                                  span={opts.span}
                                                  callback={opts.callback}></page-angel-action-results-controller>

            <page-tabs core={page_tabs}
                       callback={clickTab}></page-tabs>
        </div>
    </section>

    <div>
        <page-angel-action-results_tab-total source={opts.source}
                                             span={opts.span}
                                             callback={opts.callback}></page-angel-action-results_tab-total>
        <page-angel-action-results_tab-date source={opts.source}
                                            span={opts.span}
                                            callback={opts.callback}></page-angel-action-results_tab-date>
        <page-angel-action-results_tab-deamon source={opts.source}
                                              span={opts.span}
                                              callback={opts.callback}></page-angel-action-results_tab-deamon>
    </div>

    <script>
     this.default_tag = 'home';
     this.active_tag = null;
     this.page_tabs = new PageTabs([
         {code: 'total', label: '悪魔 別',          tag: 'page-angel-action-results_tab-total' },
         {code: 'date',  label: '日別 + Impure 別', tag: 'page-angel-action-results_tab-date' },
         {code: 'deamo', label: '日別 + 悪魔 別',   tag: 'page-angel-action-results_tab-deamon' },
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

    <style>
     page-angel-action-results {
         display:block;
         margin-bottom: 222px;
     }
     page-angel-action-results .tabs li {
         margin-right: 6px;
     }
     page-angel-action-results .tabs.is-boxed a {
         background: rgba(255, 255, 255, 0.6)
     }
    </style>

</page-angel-action-results>
