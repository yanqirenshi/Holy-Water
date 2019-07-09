<deamon-page-card-pool>

    <div class="grid">
        <deamon-page-card each={obj in list()}
                          class="grid-item"
                          source={obj}
                          callback={callback}></deamon-page-card>
    </div>

    <script>
     this.list = () => {
         return new HolyWater().pageDeamonContentsList(this.opts.source);
     };
    </script>

    <script>
     this.layout = () => {
         var elem = document.querySelector('deamon-page-card-pool .grid');

         this.msnry = new Masonry(elem, {
             itemSelector: 'deamon-page-card-pool .grid-item',
             columnWidth: 11,
             gutter: 11,
         });
         this.msnry.layout();
     }
     this.callback = (action) => {
         if (action=='refresh') {
             this.layout();

             return;
         }
     };
     this.on('updated', () => {
         this.layout();
     })
     this.on('update', () => {
         this.layout();
     });
    </script>


    <style>
     deamon-page-card-pool > .grid{
         display: block;

         width:1518px;
         margin-left: auto;
         margin-right: auto;
     }
    </style>

</deamon-page-card-pool>
