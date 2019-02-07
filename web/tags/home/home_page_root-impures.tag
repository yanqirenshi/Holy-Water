<home_page_root-impures>
    <div class="flex-parent" style="height:100%; margin-top: -8px;">
        <div class="card-container">
            <div style="overflow: hidden; padding-bottom: 222px; padding-top: 22px;">
                <impure-card each={impure in impures()}
                             data={impure}></impure-card>
            </div>
        </div>
    </div>

    <script>
     this.impures = () => {
         let out = STORE.get('impures').list.sort((a, b) => {
             return a.id > b.id ? 1 : -1;
         });

         let filter = this.opts.filter;
         if (this.opts.filter===null)
             return out;

         return out.filter((d) => {
             return d.name.toLowerCase().indexOf(filter.toLowerCase()) >= 0;
         });
     };
     STORE.subscribe((action) => {
         let update_only = [
             'FETCHED-MALEDICT-IMPURES',
             'STARTED-ACTION',
             'STOPED-ACTION',
             'SAVED-IMPURE',
         ]

         if (update_only.indexOf(action.type)>=0)
             this.update();

         if (action.type=='CREATED-MALEDICT-IMPURES')
             if (this.opts.maledict.id == action.maledict.id)
                 ACTIONS.fetchMaledictImpures(this.opts.maledict.id);

         if (action.type=='MOVED-IMPURE')
             ACTIONS.fetchMaledictImpures(this.opts.maledict.id);

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
