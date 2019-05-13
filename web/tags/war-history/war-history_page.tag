<war-history-page class="page-contents">
    <div style="margin-top:22px;"></div>

    <war-history-page-controller term={term}
                                 callback={controllerCallbak}></war-history-page-controller>

    <section class="section" style="padding-top:33px; padding-bottom:11px;">
        <div class="container">
            <page-tabs core={page_tabs}
                       callback={clickTab}></page-tabs>
        </div>
    </section>

    <div>
        <war-history-page_tab_days  class="hide" source={page_data}></war-history-page_tab_days>
        <war-history-page_tab_weeks class="hide"></war-history-page_tab_weeks>
        <war-history-page_tab_month class="hide"></war-history-page_tab_month>
    </div>

    <script>
     this.page_data = { summary: { deamons: [] } };

     let end = moment().startOf();
     let start = moment(end).add(-7, 'd');
     this.term = { from: start, to: end };

     this.on('mount', () => {
         ACTIONS.fetchPagesWarHistory(this.term.from, this.term.to);
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-WAR-HISTORY') {
             this.page_data = action.response;
             this.update();
             return;
         }
     });
    </script>

    <script>
     this.controllerCallbak = (action, data) => {
         this.term.from = data.from;
         this.term.to   = data.to;

         ACTIONS.fetchPagesWarHistory(this.term.from, this.term.to);
     };
    </script>

    <script>
     this.default_tag = 'home';
     this.active_tag = null;
     this.page_tabs = new PageTabs([
         {code: 'days',  label: 'Overview',     tag: 'war-history-page_tab_days' },
         {code: 'weeks', label: '作業時間統計', tag: 'war-history-page_tab_weeks' },
         {code: 'month', label: '浄化明細',     tag: 'war-history-page_tab_month' },
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
     war-history-page .tabs ul {
         border-bottom-color: rgb(254, 242, 99);
         border-bottom-width: 2px;
     }
     war-history-page .tabs.is-boxed li.is-active a {
         background-color: rgba(254, 242, 99, 0.55);
         border-color: rgb(254, 242, 99);

         text-shadow: 0px 0px 11px #fff;
         color: #333;
         font-weight: bold;
     }
     war-history-page .tabs.is-boxed a {
         text-shadow: 0px 0px 8px #fff;
         font-weight: bold;
     }
    </style>
</war-history-page>
