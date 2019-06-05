<impure-card-large>
    <div class="card hw-box-shadow">

        <div class="card-content" style="display:flex;flex-direction:column;">
            <div>
                <page-tabs core={page_tabs} callback={clickTab}></page-tabs>
            </div>

            <div style="margin-top:11px; flex-grow:1;">
                <impure-card-large_tab_show         class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_show>
                <impure-card-large_tab_edit         class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_edit>
                <impure-card-large_tab_deamon       class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_deamon>
                <impure-card-large_tab_incantation  class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_incantation>
                <impure-card-large_tab_create-after class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_create-after>
                <impure-card-large_tab_finish       class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_finish>
            </div>
        </div>

        <impure-card-footer callback={this.opts.callback}
                            data={opts.data}
                            maledict={opts.maledict}
                            status={opts.status}
                            mode="large"></impure-card-footer>
    </div>

    <script>
     STORE.subscribe((action) => {
         if (action.type=='SAVED-IMPURE') {
         }
     });
    </script>

    <script>
     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
    </script>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'show',         label: '照会',           tag: 'impure-card-large_tab_show' },
         {code: 'edit',         label: '編集',           tag: 'impure-card-large_tab_edit' },
         {code: 'deamon',       label: '悪魔',           tag: 'impure-card-large_tab_deamon' },
         {code: 'incantation',  label: '呪文',           tag: 'impure-card-large_tab_incantation' },
         {code: 'create-after', label: '後続作業の作成', tag: 'impure-card-large_tab_create-after' },
         {code: 'finish',       label: '完了',           tag: 'impure-card-large_tab_finish' },
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
     impure-card-large > .card {
         width: calc(222px + 222px + 222px + 22px + 22px);
         height: calc(188px + 188px + 22px + 1px);
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         border: 1px solid #dddddd;
         border-radius: 5px;

         display: flex;
         flex-direction: column;
     }
     impure-card-large > .card .card-content{
         padding: 22px 22px;
         overflow: auto;
         flex-grow: 1;
     }
     impure-card-large .tabs {
         font-size:12px;
     }
    </style>
</impure-card-large>
