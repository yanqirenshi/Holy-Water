<orthodoxs-page class="page-contents">

    <section class="section" style="padding-top: 55px; padding-bottom: 11px;">
        <div class="container">
            <page-tabs core={page_tabs}
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

    <style>
     orthodoxs-page .tabs ul {
         border-bottom-color: rgb(254, 242, 99);
         border-bottom-width: 2px;
     }
     orthodoxs-page .tabs.is-boxed li.is-active a {
         background-color: rgba(254, 242, 99, 1);
         border-color: rgb(254, 242, 99);

         text-shadow: 0px 0px 11px #fff;
         color: #333;
         font-weight: bold;
     }
     orthodoxs-page .tabs.is-boxed a {
         text-shadow: 0px 0px 8px #fff;
         font-weight: bold;
     }
    </style>
</orthodoxs-page>
