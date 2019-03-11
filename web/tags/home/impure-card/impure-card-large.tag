<impure-card-large>
    <div class="card hw-box-shadow">
        <header class="card-header">
            <p class="card-header-title">
                やること
            </p>
            <a href="#" class="card-header-icon" aria-label="more options">
                <span class="icon"
                      draggable="true"
                      dragstart={dragStart}
                      dragend={dragEnd}>
                    <icon-ranning></icon-ranning>
                </span>
            </a>
        </header>

        <div class="card-content">
            <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

            <div style="margin-top: 11px;">
                <impure-card-large_tab_show         class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_show>
                <impure-card-large_tab_edit         class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_edit>
                <impure-card-large_tab_finish       class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_finish>
                <impure-card-large_tab_create-after class="hide" data={opts.data} callback={opts.callback}></impure-card-large_tab_create-after>
            </div>
        </div>

        <footer class="card-footer">
            <span class="card-footer-item start" action="start-action" onclick={clickButton}>Start</span>
            <span class="card-footer-item stop"  action="stop-action"  onclick={clickButton}>Stop</span>
            <span class="card-footer-item open"  action="switch-small" onclick={clickButton}>Small</span>
        </footer>
    </div>

    <script>
     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;

         this.opts.callback(action);
     };
     this.dragStart = (e) => {
         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
     };
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
         {code: 'finish',       label: '完了',           tag: 'impure-card-large_tab_finish' },
         {code: 'create-after', label: '後続作業の作成', tag: 'impure-card-large_tab_create-after' },
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
     impure-card-large > .card {
         width: calc(222px + 222px + 222px + 22px + 22px);
         height: calc(222px + 222px + 22px);
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         border: 1px solid #dddddd;
         border-radius: 5px;
     }
     impure-card-large > .card .card-content{
         height: calc(222px + 222px + 22px - 49px - 48px);
         padding: 11px 22px;
         overflow: auto;
     }
    </style>
</impure-card-large>
