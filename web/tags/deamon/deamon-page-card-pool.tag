<deamon-page-card-pool>

    <div class="grid">
        <deamon-page-card each={obj in list()}
                          class="grid-item"
                          source={obj}></deamon-page-card>
    </div>

    <script>
     this.list = () => {
         return new HolyWater().pageDeamonContentsList(this.opts.source);
     };
    </script>

    <script>
     this.on('updated', () => {
         var elem = document.querySelector('deamon-page-card-pool .grid');

         this.msnry = new Masonry(elem, {
             itemSelector: 'deamon-page-card-pool .grid-item',
             columnWidth: 11,
             gutter: 11,
         });
         this.msnry.layout();
     })
     this.on('update', () => {
         var elem = document.querySelector('deamon-page-card-pool .grid');

         this.msnry = new Masonry(elem, {
             itemSelector: 'deamon-page-card-pool .grid-item',
             columnWidth: 11,
             gutter: 11,
         });
         this.msnry.layout();
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
