<home_impures class={hide()}>
    <!-- <div style="padding-left:22px;">Debug: maledict={this.opts.maledict ? this.opts.maledict.name : ''}</div> -->

    <div class="flex-parent" style="height:100%; margin-top: -8px;">
        <div class="card-container">
            <div style="overflow: hidden; padding-bottom: 222px; padding-top: 22px;">

                <impure-card each={impure in impures()}
                             data={impure}
                             open={open_cards[impure.id]}
                             callbacks={callbacks}></impure-card>

            </div>
        </div>
    </div>

    <script>
     this.open_cards = {};
     this.callbacks = {
         switchSize: (size, data) => {
             if (size=='small')
                 delete this.open_cards[data.id]
             else if (size=='large')
                 this.open_cards[data.id] = true;

             this.update();
         }
     };
    </script>

    <script>
     this.hide = () => {
         return this.opts.maledict ? '' : 'hide';
     };
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
    </script>

    <script>
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-MALEDICT-IMPURES') {
             this.update();

             return;
         }

         if (action.type=='MOVED-IMPURE' ||
             action.type=='FINISHED-IMPURE' ||
             action.type=='TRANSFERD-IMPURE-TO-ANGEL' ||
             action.type=='STARTED-ACTION' ||
             action.type=='STOPED-ACTION' ||
             action.type=='SAVED-IMPURE') {

             ACTIONS.fetchMaledictImpures(this.opts.maledict.id);
         }
     });
    </script>

    <style>
     home_impures .flex-parent {
         display: flex;
         flex-direction: column;
     }

     home_impures .card-container {
         padding-right: 22px;
         display: block;
         overflow: auto;
         overflow-x: hidden;
         flex-grow: 1;
     }
    </style>
</home_impures>
