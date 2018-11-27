<purges_page_root>
    <div style="padding:22px;">
        <div class="card">
            <header class="card-header">
                <p class="card-header-title">Purge hisotry</p>
                <button class="button refresh" onclick={clickRefresh}>Refresh</button>
            </header>

            <div class="card-content">
                <purges-list data={data()} callback={callback}></purges-list>
            </div>
        </div>
    </div>

    <purge-result-editor data={edit_target} callback={callback}></purge-result-editor>

    <script>
     this.edit_target = null;

     this.clickRefresh = () => {
         ACTIONS.fetchPurgeHistory();
     };
     this.callback = (action, data) => {
         if (action=='open-purge-result-editor') {
             this.edit_target = STORE.get('purges').ht[data.id];
             this.tags['purge-result-editor'].update();
             return;
         }

         if (action=='close-purge-result-editor') {
             this.edit_target = null;
             this.tags['purge-result-editor'].update();
             return;
         }

         if (action=='save-purge-result-editor') {
             ACTIONS.saveActionResult(data);
             return;
         }
     };
    </script>

    <script>
     this.on('mount', () => {
         ACTIONS.fetchPurgeHistory();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PURGE-HISTORY')
             this.update();
     });
    </script>

    <script>
     this.data = () => {
         let list = STORE.get('purges').list.sort((a, b) => {
             return a.start < b.start ? 1 : -1;
         });

         return list;
     };
    </script>

    <style>
     purges_page_root {
         height: 100%;
         width: 100%;
         display: block;
         overflow: auto;
     }

     purges_page_root .card {
         border-radius: 8px;
     }

     purges_page_root button.refresh{
         margin-top:6px;
         margin-right:8px;
     }
    </style>
</purges_page_root>
