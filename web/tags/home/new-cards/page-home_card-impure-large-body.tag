<page-home_card-impure-large-body>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div class="tab-contents">
        <page-home_card-impure-large_tab-show         class="hide"></page-home_card-impure-large_tab-show>
        <page-home_card-impure-large_tab-edit         class="hide"></page-home_card-impure-large_tab-edit>
        <page-home_card-impure-large_tab-deamon       class="hide"></page-home_card-impure-large_tab-deamon>
        <page-home_card-impure-large_tab-incantation  class="hide"></page-home_card-impure-large_tab-incantation>
        <page-home_card-impure-large_tab-create-after class="hide"></page-home_card-impure-large_tab-create-after>
        <page-home_card-impure-large_tab-finish       class="hide"></page-home_card-impure-large_tab-finish>
    </div>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'show',         label: '照会',   tag: 'page-home_card-impure-large_tab-show' },
         {code: 'edit',         label: '編集',   tag: 'page-home_card-impure-large_tab-edit' },
         {code: 'deamon',       label: '悪魔',   tag: 'page-home_card-impure-large_tab-deamon' },
         {code: 'incantation',  label: '呪文',   tag: 'page-home_card-impure-large_tab-incantation' },
         {code: 'create-after', label: '後続成', tag: 'page-home_card-impure-large_tab-create-after' },
         {code: 'finish',       label: '完了',   tag: 'page-home_card-impure-large_tab-finish' },
     ]);

     this.on('mount', () => {

         let len = Object.keys(this.tags).length;
         if (len==0) // TODO: これはどんなとき？
             return;

         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
    </script>

    <style>
     page-home_card-impure-large-body {
         flex-grow: 1;

         display: flex;
         flex-direction: column;
     }
     page-home_card-impure-large-body > .tab-contents{
         flex-grow: 1;
     }
    </style>

</page-home_card-impure-large-body>
