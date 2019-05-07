<orthodoxs-page>
    <section class="section" style="padding-bottom: 11px;">
        <div class="container">
            <h1 class="title hw-text-white">正教会</h1>
            <h2 class="subtitle hw-text-white">正教会=チーム</h2>

        </div>
    </section>

    <section class="section" style="padding-top: 11px; padding-bottom: 11px;">
        <div class="container">
            <page-tabs core={page_tabs}
                       type="toggle"
                       callback={clickTab}></page-tabs>
        </div>
    </section>

    <div>
        <orthodoxs-page_tab-orthdoxs  class="hide"></orthodoxs-page_tab-orthdoxs>
        <orthodoxs-page_tab-exorcists class="hide"></orthodoxs-page_tab-exorcists>
    </div>

    <script>
     this.default_tag = 'home';
     this.active_tag = null;
     this.page_tabs = new PageTabs([
         {code: 'orthdoxs',  label: '正教会', tag: 'orthodoxs-page_tab-orthdoxs' },
         {code: 'exorcists', label: '祓魔師', tag: 'orthodoxs-page_tab-exorcists' },
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
     orthodoxs-page {
         width: 100%;
         height: 100%;
         display: block;
         overflow: auto;
     }
    </style>

</orthodoxs-page>
