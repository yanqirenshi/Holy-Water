<war-history_page>

    <section class="section">
        <div class="container">
            <page-tabs core={page_tabs}
                       callback={clickTab}></page-tabs>
        </div>
    </section>

    <div>
        <war-history_root_tab_days class="hide"></war-history_root_tab_days>
        <war-history_root_tab_weeks class="hide"></war-history_root_tab_weeks>
        <war-history_root_tab_month class="hide"></war-history_root_tab_month>
    </div>

    <script>
     this.default_tag = 'home';
     this.active_tag = null;
     this.page_tabs = new PageTabs([
         {code: 'days',  label: '日', tag: 'war-history_root_tab_days' },
         {code: 'weeks', label: '週', tag: 'war-history_root_tab_weeks' },
         {code: 'month', label: '月', tag: 'war-history_root_tab_month' },
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
</war-history_page>
