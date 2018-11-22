<home_page_root-impures>
    <div class="flex-parent" style="height:100%; margin-top: -8px;">
        <div class="card-container">
            <div style="overflow: hidden; padding-bottom: 222px; padding-top: 8px;">
                <impure-card each={impure in impures()}
                             data={impure}></impure-card>
            </div>
        </div>
    </div>

    <script>
     this.impures = () => {
         return STORE.get('impures').list;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-MALEDICT-IMPURES')
             this.update();
         if (action.type=='CREATED-MALEDICT-IMPURES')
             this.update();
         if (action.type=='STARTED-ACTION')
             this.update();
         if (action.type=='STOPED-ACTION')
             this.update();
         if (action.type=='FINISHED-IMPURE')
             ACTIONS.fetchMaledictImpures(this.opts.maledict.id);
     });
    </script>

    <style>
     home_page_root-impures .flex-parent {
         display: flex;
         flex-direction: column;
     }

     home_page_root-impures .card-container {
         padding-right: 22px;
         display: block;
         overflow: auto;
         overflow-x: hidden;
         flex-grow: 1;
     }
    </style>
</home_page_root-impures>
