<home_impures class={hide()}>

    <!-- TODO: このへん混乱しとるね。。 -->
    <div class="flex-parent" style="height:100%; margin-top: -8px;">
        <div class="card-container">
            <div>

                <hw-card each={obj in impures()}
                         source={obj}
                         maledict={maledict()}
                         open={open_cards[obj.id]}
                         callbacks={callbacks}></hw-card>

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
     home_impures .card-container > div {
         padding-bottom: 222px;
         padding-top: 22px;
         display: flex;
         flex-wrap: wrap;
     }
     home_impures .card-container > div > * {
         margin: 0px 0px 22px 22px;
     }
    </style>

</home_impures>
