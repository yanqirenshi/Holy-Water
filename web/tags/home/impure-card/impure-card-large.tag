<impure-card-large>
    <div class="card" style="box-shadow: 0px 0px 8px #eeeeee;">
        <header class="card-header">
            <p class="card-header-title">
                やること
            </p>
            <a href="#" class="card-header-icon" aria-label="more options">
                <span class="icon"
                      draggable="true"
                      dragstart={dragStart}
                      dragend={dragEnd}>
                    <i class="fas fa-running"></i>
                </span>
            </a>
        </header>

        <div class="card-content">
            <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

            <div style="margin-top: 11px;">
                <impure-card-large_tab_actions class="hide" data={opts.data}></impure-card-large_tab_actions>
                <impure-card-large_tab_edit    class="hide" data={opts.data}></impure-card-large_tab_edit>
                <impure-card-large_tab_hisotry class="hide" data={opts.data}></impure-card-large_tab_hisotry>
                <impure-card-large_tab_show    class="hide" data={opts.data}></impure-card-large_tab_show>
            </div>
        </div>

        <footer class="card-footer">
            <a class="card-footer-item">Start</a>
            <a class="card-footer-item">Stop</a>
            <a class="card-footer-item" onclick={clickCloseButton}>Close</a>
        </footer>
    </div>

    <script>
     this.clickCloseButton = (e) => {
         this.opts.callback('switch-small');
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
         {code: 'show',    label: '照会',     tag: 'impure-card-large_tab_show' },
         {code: 'edit',    label: '編集',     tag: 'impure-card-large_tab_edit' },
         {code: 'actions', label: '実績',     tag: 'impure-card-large_tab_actions' },
         {code: 'history', label: '移動履歴', tag: 'impure-card-large_tab_hisotry' },
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
         width: calc(222px + 222px + 22px);
         height: calc(222px + 222px + 222px + 22px);
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         box-shadow: 0px 0px 8px #ffffff;
         border: 1px solid #dddddd;
         border-radius: 5px;
     }
     impure-card-large > .card .card-content{
         height: calc(222px + 222px + 222px + 22px - 49px - 48px);
         padding: 11px 22px;
         overflow: auto;
     }
    </style>
</impure-card-large>
