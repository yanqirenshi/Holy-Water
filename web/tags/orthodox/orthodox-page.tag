<orthodox-page>

    <hw-page-header title="正教会" type="child"></hw-page-header>

    <section class="section" style="padding-top: 11px; padding-bottom: 11px;">
        <div class="container">
            <page-tabs core={page_tabs}
                       type="toggle"
                       callback={clickTab}></page-tabs>
        </div>
    </section>

    <div>
        <orthodox-page_tab-basic   class="hide"></orthodox-page_tab-basic>
        <orthodox-page_tab-members class="hide"></orthodox-page_tab-members>
        <orthodox-page_tab-paladin   class="hide"></orthodox-page_tab-paladin>
        <orthodox-page_tab-primate   class="hide"></orthodox-page_tab-primate>
    </div>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'basic',   label: '基本情報', tag: 'orthodox-page_tab-basic' },
         {code: 'members', label: '祓魔師',   tag: 'orthodox-page_tab-members' },
         {code: 'paladin', label: '聖騎士',   tag: 'orthodox-page_tab-paladin' },
         {code: 'primate', label: '首座主教', tag: 'orthodox-page_tab-primate' },
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
     this.orthodox = () => {
         let id = location.hash.split('/').reverse()[0];

         return STORE.get('orthodoxs.ht.' + id);
     };

     ACTIONS.fetchPagesOrthodox(this.orthodox());
    </script>

</orthodox-page>
