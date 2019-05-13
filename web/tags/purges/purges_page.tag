<purges_page class="page-contents">
    <div style="padding: 33px 88px 88px 88px;">
        <div>
            <h1 class="title hw-text-white">期間</h1>
            <purges_page_filter style="margin-bottom:22px; padding-left:33px; padding-right:33px;"
                                from={from}
                                to={to}
                                callback={callback}></purges_page_filter>

        </div>

        <div>
            <h1 class="title hw-text-white">Summary</h1>
            <div style="display:flex; padding-left:33px; padding-right:33px;">
                <div style="margin-right: 88px;">
                    <purges_page_group-span data={data()}></purges_page_group-span>
                </div>
                <div>
                    <purges_page_group-span-deamon data={data()}></purges_page_group-span-deamon>
                </div>
            </div>
        </div>

        <div style="margin-top:33px;">
            <h1 class="title hw-text-white">Guntt Chart</h1>
            <div style="padding-left:33px; padding-right:33px;">
                <purges_page_guntt-chart data={data()}></purges_page_guntt-chart>
            </div>
        </div>

        <div style="margin-top:33px;">
            <h1 class="title hw-text-white">Purge hisotry</h1>
            <div style="display:flex; padding-left:33px; padding-right:33px;">
                <purges-list source={purges} callback={callback}></purges-list>
            </div>
        </div>
    </div>

    <purge-result-editor data={edit_target}
                         callback={callback}></purge-result-editor>

    <modal-change-deamon open={modal_change_deamon_open}
                         source={modal_data}
                         callback={callback}></modal-change-deamon>

    <div style="height:111px;"></div>

    <script>
     this.purges = [];
     this.modal_change_deamon_open = false;
    </script>

    <script>
     this.from = moment().startOf('day');
     this.to   = moment().add(1, 'd').startOf('day');
     this.moveDate = (unit, amount) => {
         this.from = this.from.add(amount, unit);
         this.to   = this.to.add(amount, unit);

         this.tags['purges_page_filter'].update();
     };
    </script>

    <script>
     this.edit_target = null;
     this.modal_data = null;
     this.callback = (action, data) => {
         if ('open-modal-change-deamon'==action) {
             this.modal_change_deamon_open = true;

             this.modal_data = this.purges.find((d) => {
                 return d.purge_id == data.purge_id;
             });

             if (this.modal_data==null)
                 return;

             this.update();

             return;
         }
         if ('close-modal-change-deamon'==action) {
             this.modal_change_deamon_open = false;
             this.update();

             return;
         }

         if ('open-purge-result-editor'==action) {
             this.edit_target = STORE.get('purges').ht[data.id];
             this.tags['purge-result-editor'].update();

             return;
         }

         if ('close-purge-result-editor'==action) {
             this.edit_target = null;
             this.tags['purge-result-editor'].update();
             return;
         }

         if ('save-purge-result-editor'==action)
             ACTIONS.saveActionResult(data);

         if ('move-date'==action)
             this.moveDate(data.unit, data.amount);

         if ('refresh'==action)
             this.refreshData();
     };
    </script>

    <script>
     this.refreshData = () => {
         ACTIONS.fetchPurgeHistory(this.from, this.to);
         ACTIONS.fetchPagesPurges(this.from, this.to);
     };
     this.on('mount', () => {
         this.refreshData();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-PURGES') {
             this.purges = action.response.purges.map((d) => {
                 d.purge_start = moment(d.purge_start);
                 d.purge_end   = moment(d.purge_end);
                 return d;
             });

             this.update();

             return;
         }

         if (action.type=='FETCHED-PURGE-HISTORY') {
             this.update();
             return;
         }

         if (action.type=='SAVED-ACTION-RESULT') {
             this.edit_target = null;
             ACTIONS.pushSuccessMessage('Purge の実績の変更が完了しました。');
             ACTIONS.fetchPurgeHistory(this.from, this.to);
             return;
         }
     });
    </script>

    <script>
     this.data = () => {
         let list = STORE.get('purges');

         return list;
     };
    </script>

    <style>
     purges_page {
         height: 100%;
         width: 100%;
         display: block;
         overflow: auto;
     }

     purges_page .card {
         border-radius: 8px;
     }

     purges_page button.refresh{
         margin-top:6px;
         margin-right:8px;
     }
    </style>
</purges_page>
