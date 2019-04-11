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
            <page-tabs core={page_tabs}
                       callback={clickTab}
                       type="toggle"></page-tabs>
        </div>
    </section>

    <div class="tab-contents-area">
        <impure_page_tab-basic    class="hide" source={impure}></impure_page_tab-basic>
        <impure_page_tab-purges   class="hide" source={impure}></impure_page_tab-purges>
        <impure_page_tab-requests class="hide" source={impure}></impure_page_tab-requests>
        <impure_page_tab-chains   class="hide" source={impure}></impure_page_tab-chains>
    </div>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'basic',    label: '基本情報', tag: 'impure_page_tab-basic' },
         {code: 'purges',   label: '浄化履歴', tag: 'impure_page_tab-purges' },
         {code: 'requests', label: '依頼履歴', tag: 'impure_page_tab-requests' },
         {code: 'chains',   label: '連鎖',     tag: 'impure_page_tab-chains' },
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

    <style>
     impure_page page-tabs li a{
         background: #fff;
     }
    </style>
</impure_page>
