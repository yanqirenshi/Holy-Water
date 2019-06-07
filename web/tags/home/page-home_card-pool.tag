<page-home_card-pool class={hide()}>

    <!-- TODO: このへん混乱しとるね。。 -->
    <div class="flex-parent" style="height:100%; margin-top: -8px;">
        <div class="card-container">
            <div>

                <hw-card each={obj in impures()}
                         source={obj}
                         maledict={maledict()}
                         open={openCard(obj)}
                         callbacks={callbacks}></hw-card>

            </div>
        </div>
    </div>

    <script>
     this.open_cards = {};
     this.openCard = (obj) => {
         let ht = this.open_cards[obj._class];

         if (!ht)
             return false;

         return ht[obj.id] ? true : false;
     };
     this.callbacks = {
         switchSize: (size, data) => {
             let cls = data._class;
             let id  = data.id;
             let ht  = this.open_cards;

             if (!ht[cls])
                 ht[cls] = {};

             if (size=='small')
                 delete ht[cls][data.id]
             else if (size=='large')
                 ht[cls][data.id] = true;

             this.update();
         }
     };
    </script>

    <script>
     this.maledict = () => {
         return this.opts.maledict;
     };
     this.hide = () => {
         return this.opts.maledict ? '' : 'hide';
     };
     this.impures = () => {
         let list = this.opts.source;

         let out = list.sort((a, b) => {
             return a.id > b.id ? 1 : -1;
         });

         let keyword = this.opts.filter;
         if (this.opts.filter===null)
             return out;

         keyword = keyword.toLowerCase();
         return out.filter((d) => {
             if (d.deamon_name_short &&
                 d.deamon_name_short.toLowerCase().indexOf(keyword) >= 0)
                 return true;

             if (d.name.toLowerCase().indexOf(keyword) >= 0)
                 return true;

             return false;
         });
     };
    </script>

    <style>
     page-home_card-pool .flex-parent {
         display: flex;
         flex-direction: column;
     }

     page-home_card-pool .card-container {
         padding-right: 22px;
         display: block;
         overflow: auto;
         overflow-x: hidden;
         flex-grow: 1;
     }
     page-home_card-pool .card-container > div {
         padding-bottom: 222px;
         padding-top: 22px;
         display: flex;
         flex-wrap: wrap;
     }
     page-home_card-pool .card-container > div > * {
         margin: 0px 0px 22px 22px;
     }
    </style>

</page-home_card-pool>
